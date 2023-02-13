import std/[os, strformat, strutils, times]

var 
  inPath* {.threadvar.}:string
  outPath* {.threadvar.}: string
  lastBuildTime* = getTime() - initDuration(seconds=2)

proc updateBuild*(sourceFilePath, targetDir: string) {.thread.} =
  if outPath != "" and 
  not outPath.startsWith "--out:":
    outPath = &"""--out:"{outPath}""""
  let
    cmd = &"nim js {outPath} {inPath}"
    now = getTime()
    durationSinceLastBuild = now - lastBuildTime
  if durationSinceLastBuild.inSeconds > 1:
    discard os.execShellCmd(cmd)
    lastBuildTime = now
