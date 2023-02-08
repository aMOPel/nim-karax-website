import std/[strformat, osproc, os, strutils, times, re]
import nosey

const dateFormat = "dd-MM-yyyy HH:mm"

proc mdToKarax(sourceFilePath, targetDir: string) =
  echo &"Updating {targetDir/sourceFilePath.splitPath.tail}"
  let 
    sourceFileName = sourceFilePath.splitFile.name
    mdFileName = sourceFilePath
    htmlFileName = sourceFilePath.changeFileExt "html"
    nimFileName = targetDir/sourceFileName.changeFileExt("nim")
    currentDate = now().format dateFormat
  discard execCmd(&"./nimbledeps/bin/markdown < {mdFileName} > {htmlFileName}")
  discard execCmd(&"./nimbledeps/bin/html2karax {htmlFileName} --out:{nimFileName}")
  var nimFile = readFile(nimFileName)
  nimFile = nimFile.replace("""
proc createDom(): VNode =
  result = buildHtml:
""",
&"""
proc createDom*(): VNode =
  result = buildHtml(article):
"""
  )
  nimFile = nimFile.replace("setRenderer createDom", "")
  writeFile(nimFileName, nimFile)
  removeFile(htmlFileName)

  const ccFileName = "src/website/contentCollection.nim"
  var
    ccRead = ccFileName.readFile
    ccTemplatePattern = &"""
import content\/{sourceFileName}
contents\.add Content\(
  name: "{sourceFileName}",
  content: {sourceFileName}\.createDom,
  creationTime: "(.*)",
  lastWriteTime: ".*"
\)
"""
    ccTemplateBase = &"""
import content/{sourceFileName}
contents.add Content(
  name: "{sourceFileName}",
  content: {sourceFileName}.createDom,
"""
    ccTemplateNew = ccTemplateBase & &"""
  creationTime: "{currentDate}",
  lastWriteTime: "{currentDate}"
)
"""
    ccTemplateSub = ccTemplateBase & &"""
  creationTime: "$1",
  lastWriteTime: "{currentDate}"
)
"""
  if ccRead.find(ccTemplateBase) < 0:
    let ccAppend = ccFileName.open(fmAppend)
    ccAppend.write(ccTemplateNew)
    ccAppend.close()
  else:
    ccFileName.writeFile(ccRead.replacef(re ccTemplatePattern, ccTemplateSub))

proc rmKarax(sourceFilePath, targetDir: string) =
  echo &"Removing {targetDir/sourceFilePath.splitPath.tail}"
  let 
    sourceFileName = sourceFilePath.splitFile.name
    nimFileName = targetDir/sourceFileName.changeFileExt("nim")
  nimFileName.removeFile

  const ccFileName = "src/website/contentCollection.nim"
  var
    ccRead = ccFileName.readFile
    ccTemplatePattern = &"""
import content\/{sourceFileName}
contents\.add Content\(
  name: "{sourceFileName}",
  content: {sourceFileName}\.createDom,
  creationTime: ".*",
  lastWriteTime: ".*"
\)
"""
  ccFileName.writeFile(ccRead.replace(re ccTemplatePattern, ""))

when isMainModule:

  # parse cmdline -w and/or -j=[file]
  import std/[parseopt, json]
  type Mode = enum mWatch, mOnce
  var
    sourceDir = "content"
    targetDir = "src/website/content"
    jsonFile = "../contentHashes.json"
    mode = mOnce
  var p = commandLineParams().initOptParser(shortNoVal={'w'})
  while true:
    p.next()
    case p.kind:
    of cmdEnd: break
    of cmdShortOption, cmdLongOption:
      case p.key:
      of "j":
        if p.val != "":
          jsonFile = p.val
          echo "using json file " & p.val
      of "w":
        mode = mWatch
        echo "going into watch mode"
      of "s":
        if p.val != "":
          sourceDir = p.val
          echo "using source directory " & p.val
      of "t":
        if p.val != "":
          targetDir = p.val
          echo "using target directory " & p.val
      of ["h", "help"]:
        echo """
    -s=[sourceDir]    default: "content"
    -t=[targetDir]    default: "src/website/content"
    -j=[jsonFile]     default: "../contentHashes.json"
    -w                run watcher
    """
        quit()
    of cmdArgument:
      echo "doesn't accept arguments"

  # running
  case mode:
  of mWatch:
    watch(sourceDir, targetDir, 5000, mdToKarax, rmKarax, jsonFile)
  of mOnce:
    var 
      ss: DirState
      ncd: NewChangedDeleted
    ss = readFile(jsonFile).parseJson.to(ss.type) 
    ncd = ss.updateDirState
    applyDirState(ss, targetDir, ncd, mdToKarax, rmKarax)
    writeFile(jsonFile.addFileExt("json"), $ %*ss)
