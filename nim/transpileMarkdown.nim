import std/[strformat, osproc, os, strutils, times]
import nosey

proc mdToKarax(sourceFilePath, targetDir: string) =
  echo &"Updating {targetDir/sourceFilePath.splitPath.tail}"
  let 
    sourceFileName = sourceFilePath.splitFile.name
    mdFileName = sourceFilePath
    htmlFileName = sourceFilePath.changeFileExt "html"
    nimFileName = targetDir/sourceFileName.changeFileExt("nim")
    currentDate = now().format("dd-MM-yyyy HH:mm")
  discard execCmd(&"./nimbledeps/bin/markdown < {mdFileName} > {htmlFileName}")
  discard execCmd(&"./nimbledeps/bin/html2karax {htmlFileName} --out:{nimFileName}")
  var nimFile = readFile(nimFileName)
  nimFile = nimFile.replace("""
proc createDom(): VNode =
  result = buildHtml:
""",
&"""
proc createDom*(): VNode =
  result = buildHtml(tdiv):
    p(id="timestamp"): text "last updated {currentDate}"
"""
  )
  nimFile = nimFile.replace("setRenderer createDom", "")
  writeFile(nimFileName, nimFile)
  removeFile(htmlFileName)

  const ccFileName = "src/website/contentCollection.nim"
  var
    ccRead = ccFileName.readFile
    ccTemplate = &"""
import content/{sourceFileName}
contents.add Content(name: "{sourceFileName}", content: {sourceFileName}.createDom)
"""
  if ccRead.find(ccTemplate) < 0:
    let ccAppend = ccFileName.open(fmAppend)
    ccAppend.write(ccTemplate)
    ccAppend.close()

proc rmKarax(sourceFilePath, targetDir: string) =
  echo &"Removing {targetDir/sourceFilePath.splitPath.tail}"
  let 
    sourceFileName = sourceFilePath.splitFile.name
    nimFileName = targetDir/sourceFileName.changeFileExt("nim")
  nimFileName.removeFile

  const ccFileName = "src/website/contentCollection.nim"
  var
    ccRead = ccFileName.readFile
    ccTemplate = &"""
import content/{sourceFileName}
contents.add Content(name: "{sourceFileName}", content: {sourceFileName}.createDom)
"""
  ccFileName.writeFile(ccRead.replace(ccTemplate, ""))

when isMainModule:
  const
    sourceDir = "content"
    targetDir = "src/website/content"
    jsonFile = "../hashes.json"
  watch(sourceDir, targetDir, 5000, mdToKarax, rmKarax, jsonFile)
