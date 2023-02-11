import std/[strformat, osproc, os, strutils, times, re]
import nosey

const dateFormat = "dd-MM-yyyy HH:mm"

proc splitIndex(fileName: string):
  tuple[index: int, nameWithoutIndex: string] =
  try:
    let
      s = fileName.split('_', 1)
    result = (index: s[0].parseInt, nameWithoutIndex: s[1])
  except ValueError:
    result = (index: 0, nameWithoutIndex: fileName)

proc findCommonSubDirs(sourceDir, targetDir: string): string =
  let 
    t = targetDir.split('/')
    s = sourceDir.split('/')
  var tIndex = -1
  for ssub in s:
    tIndex = t.find(ssub)
    if tIndex != -1: break
  if tIndex != -1:
    result = t[tIndex+1..^1].join("/")

proc mdToKarax(sourceFilePath, targetDir: string) =
  echo &"Updating {targetDir/sourceFilePath.splitPath.tail}"
  let 
    mdFileName = sourceFilePath
    (sourceDir, name, _) = sourceFilePath.splitFile
    subDir = findCommonSubDirs(sourceDir, targetDir)
    (index, sourceFileName) = name.splitIndex
    htmlFileName = sourceFilePath.changeFileExt "html"
    nimFileName = targetDir/sourceFileName.changeFileExt("nim")
    moduleName =  &"{subDir}_{sourceFileName}"
    currentDate = now().format dateFormat
  createDir targetDir
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
    ccTemplateBase = &"""
import content/{subDir/sourceFileName} as {moduleName}
contents.add Content(
  index: {index},
  subDir: "{subDir}",
  name: "{sourceFileName}",
  content: {moduleName}.createDom,
"""
    ccTemplatePattern = ccTemplateBase.escapeRe & """
  creationTime: "(.*)",
  lastWriteTime: ".*"
\)
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
    (sourceDir, name, _) = sourceFilePath.splitFile
    subDir = findCommonSubDirs(sourceDir, targetDir)
    (index, sourceFileName) = name.splitIndex
    nimFileName = targetDir/sourceFileName.changeFileExt("nim")
    moduleName =  &"{subDir}_{sourceFileName}"
  nimFileName.removeFile

  # remove dir if now empty
  var fileCount = 0
  for _, _ in targetDir.walkDir: fileCount.inc
  if fileCount == 0:
    echo &"Removing {targetDir} since it's empty now"
    targetDir.removeDir

  const ccFileName = "src/website/contentCollection.nim"
  var
    ccRead = ccFileName.readFile
    ccTemplateBase = &"""
import content/{subDir/sourceFileName} as {moduleName}
contents.add Content(
  index: {index},
  subDir: "{subDir}",
  name: "{sourceFileName}",
  content: {moduleName}.createDom,
"""
    ccTemplatePattern = ccTemplateBase.escapeRe & """
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
    watch(
      sourceDir,
      targetDir,
      5000,
      mdToKarax,
      rmKarax,
      jsonFile,
      doNothingWhenNoJson=false
    )
  of mOnce:
    var 
      ss: DirState
      ncd: NewChangedDeleted
    try:
      ss = readFile(jsonFile).parseJson.to(ss.type) 
    except JsonParsingError, IOError:
      let e = getCurrentException()
      echo &"{e.name}: {e.msg}"
      echo "using current state of " & sourceDir & 
        " and creating " & jsonFile & " later"
      echo ""
      ss = DirState(dirName: sourceDir)
    ncd = ss.updateDirState
    applyDirState(ss, targetDir, ncd, mdToKarax, rmKarax)
    writeFile(jsonFile.addFileExt("json"), $ %*ss)
