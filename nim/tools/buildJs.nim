import std/[os, strformat, strutils, times]

var 
  releaseFlag* = false
  inPath* {.threadvar.}: string
  outPath* {.threadvar.}: string
  lastBuildTime* = getTime() - initDuration(seconds=2)

proc updateBuild*(sourceFilePath, targetDir: string) {.thread.} =
  if outPath != "" and not outPath.startsWith "--out:":
    outPath = &"""--out:"{outPath}""""
  let
    releaseFlagStr = if releaseFlag: "-d:release" else: ""
    cmd = &"nim js {releaseFlagStr} {outPath} {inPath}"
    now = getTime()
    durationSinceLastBuild = now - lastBuildTime
  if durationSinceLastBuild.inSeconds > 1:
    discard os.execShellCmd(cmd)
    lastBuildTime = now
