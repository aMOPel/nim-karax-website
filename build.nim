import std/[strformat, osproc, os, strutils]

proc md2karax(dir: string, file: string) =
  let 
    mdFileName = &"{dir}/{file}.md"
    htmlFileName = &"{dir}/{file}.html"
    nimFileName = &"src/website/{dir}/{file}.nim"
  discard execCmd(&"./nimbledeps/bin/markdown < {mdFileName} > {htmlFileName}")
  discard execCmd(&"./nimbledeps/bin/html2karax {htmlFileName} --out:{nimFileName}")
  var nimFile = readFile(nimFileName)
  nimFile = nimFile.replace("""
proc createDom(): VNode =
  result = buildHtml:
""",
"""
proc createDom*(): VNode =
  result = buildHtml(tdiv):
"""
  )
  nimFile = nimFile.replace("setRenderer createDom", "")
  writeFile(nimFileName, nimFile)
  # discard execCmd(&"head --lines=-2 {dir}/temp.nim > {dir}/{file}.nim")
  # removeFile("$1/temp.nim"%[dir])
  removeFile(htmlFileName)

when isMainModule:
  var ccRead = open("src/website/contentCollection.nim", fmRead)
  var ccAppend = open("src/website/contentCollection.nim", fmAppend)

  for _, mdFile in walkDir("./content"):
    let 
      (dir, file, _) = mdFile.splitFile
      ccTemplate = &"""
import content/{file}
contents.add Content(name: "{file}", content: {file}.createDom)
"""
    md2karax(dir, file)
    if ccRead.readAll.find(ccTemplate) < 0:
      write(ccAppend, ccTemplate)

  ccAppend.close()
  ccRead.close()
