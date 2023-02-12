import std/[os, strformat, strutils, times]

var 
  inPath* {.threadvar.}:string
  outPath* {.threadvar.}: string
  lastBuildTime* = getTime() - initDuration(seconds=2)

proc updateHtml*(sourceFilePath, targetDir: string) {.thread.} =
  let
    cmd = &"nim r {inPath} {outPath}"
    now = getTime()
    durationSinceLastBuild = now - lastBuildTime
  if durationSinceLastBuild.inSeconds > 1:
    let errorCode = os.execShellCmd(cmd)
    lastBuildTime = now
    if errorCode != 0: quit(errorCode)
