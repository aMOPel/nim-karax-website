import std/[strformat, osproc, os, strutils, times, sha1, tables]
import jsony

const jsonFile = "../hashes.json"

var contentFiles: Table[string, string]
try:
  contentFiles = readFile(jsonFile).fromJson(contentFiles.type)
except IOError as e:
  echo "ERROR: " & e.msg

proc md2karax(dir: string, file: string) =
  let 
    mdFileName = &"{dir}/{file}.md"
    htmlFileName = &"{dir}/{file}.html"
    nimFileName = &"src/website/{dir}/{file}.nim"
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

# this watcher is already pretty good
# it only updates a .nim file, if the hash of that file has changed
# it uses the hashes.json file to sustain state through sessions. 
# hashes.json is currently not commited
# also it only updates the hashes.json if necessary
# all this works nicely with the new "last updated" timestamp in the content files
# which is in turn only updated, once a content files's contents change
# TODO: what's still missing is a system to delete the entry in contentCollection.nim
# and the src/website/content/*.nim file once a content/*.md file has been deleted
proc watch(interval: int) =
  var hashesJsonHash = contentFiles.toJson.secureHash
  while true:
    sleep(interval)
    var ccRead = readFile("src/website/contentCollection.nim")
    for p in walkDir("./content"):
      let 
        (dir, file, _) = p.path.splitFile
        ccTemplate = &"""
import content/{file}
contents.add Content(name: "{file}", content: {file}.createDom)
"""
      if file notin contentFiles or 
        contentFiles[file] != p.path.secureHashFile.`$`:
        contentFiles[file] = p.path.secureHashFile.`$`
        md2karax(dir, file)
        if ccRead.find(ccTemplate) < 0:
          let ccAppend = open("src/website/contentCollection.nim", fmAppend)
          write(ccAppend, ccTemplate)
          ccAppend.close()

    let json = contentFiles.toJson
    if hashesJsonHash != json.secureHash:
      echo "something changed, updating json"
      hashesJsonHash = json.secureHash
      writeFile(jsonFile, json)

when isMainModule:
  watch(5000)
