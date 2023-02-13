import std/[strformat, osproc, os, strutils, re, tables]

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

proc parseMarkdownMetaData(fileName: string): Table[string, string] =
  for l in fileName.lines:
    if not l.startsWith("["):
      break
    var kvpair: array[2, string]
    if l.match(re"""^\s*\[\s*(.*)\s*\]:-\s*"(.*)"\s*$""", kvpair):
      discard result.hasKeyOrPut(kvpair[0], kvpair[1])
    else:
      echo "nothing found in " & l

proc mdToKarax*(sourceFilePath, targetDir: string) =
  echo &"Updating {targetDir/sourceFilePath.splitPath.tail}"
  let 
    mdFileName = sourceFilePath
    (sourceDir, name, _) = sourceFilePath.splitFile
    subDir = findCommonSubDirs(sourceDir, targetDir)
    (index, sourceFileName) = name.splitIndex
    htmlFileName = sourceFilePath.changeFileExt "html"
    nimFileName = targetDir/sourceFileName.changeFileExt("nim")
    moduleName =  &"{subDir}_{sourceFileName}"
    mdMetaTable = mdFileName.parseMarkdownMetaData
    creationTime = mdMetaTable.getOrDefault "creationTime"
    lastWriteTime = mdMetaTable.getOrDefault "lastWriteTime"
  createDir targetDir
  discard execCmd(&"./nimbledeps/bin/markdown < {mdFileName} > {htmlFileName}")
  discard execCmd(&"./nimbledeps/bin/html2karax {htmlFileName} --out:{nimFileName}")
  var nimFile = readFile(nimFileName)
  nimFile = nimFile.replace("""
include karax / prelude

proc createDom(): VNode =
  result = buildHtml:
""",
"""
import pkg/karax/[vdom, karaxdsl]

proc createDom*(): VNode =
  result = buildHtml(article):
"""
  )
  nimFile = nimFile.replace("setRenderer createDom", "")
  writeFile(nimFileName, nimFile)
  removeFile(htmlFileName)

  const ccFileName = "src/website/contentImports.nim"
  if not ccFileName.fileExists: ccFileName.writeFile ""

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
  creationTime: "{creationTime}",
  lastWriteTime: "{lastWriteTime}"
)
"""
  if ccRead.find(ccTemplateBase) < 0:
    let ccAppend = ccFileName.open(fmAppend)
    ccAppend.write(ccTemplateNew)
    ccAppend.close()
  else:
    ccFileName.writeFile(ccRead.replacef(re ccTemplatePattern, ccTemplateNew))

proc rmKarax*(sourceFilePath, targetDir: string) =
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

  const ccFileName = "src/website/contentImports.nim"
  if not ccFileName.fileExists: ccFileName.writeFile ""
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

