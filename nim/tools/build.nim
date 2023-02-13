import std/[os, threadpool, browsers]
import pkg/[nosey]
import buildJs, transpileMarkdown, buildHtml

type Mode = enum mWatch, mOnce

template runOnceOrWatch =
  targetDir.createDir
  case mode:
  of mOnce:
    runOnce(
      sourceDir,
      targetDir,
      fileConverter,
      fileRemover,
      sourceStateJson,
    )
  of mWatch:
    watch(
      sourceDir,
      targetDir,
      1000,
      fileConverter,
      fileRemover,
      sourceStateJson,
      doNothingWhenNoJson=false
    )

proc runBuildJs(mode: Mode) {.thread.} =
  let
    sourceDir = "src/"
    targetDir = "../build/"
    inFile = "website.nim"
    outFile = "app.js"
    sourceStateJson = ""
    fileConverter = updateBuild
    fileRemover = updateBuild
  buildJs.inPath = sourceDir/inFile
  buildJs.outPath = targetDir/outFile
  runOnceOrWatch()

proc runBuildHtml(mode: Mode) {.thread.} =
  let
    sourceDir = "buildHtml/"
    targetDir = "../build/"
    inFile = "indexHtml.nim"
    outFile = "index.html"
    sourceStateJson = ""
    fileConverter = updateHtml
    fileRemover = updateHtml
  buildHtml.inPath = sourceDir/inFile
  buildHtml.outPath = targetDir/outFile
  runOnceOrWatch()

proc runPutAssets(mode: Mode) {.thread.} =
  let
    sourceDir = "../assets/"
    targetDir = "../build/assets/"
    sourceStateJson = ""
    fileConverter = defaultFileConverter
    fileRemover = defaultFileRemover
  runOnceOrWatch()

proc runTranspileMarkdown(mode: Mode) {.thread.} =
  let
    sourceDir = "../content/"
    targetDir = "src/website/content/"
    sourceStateJson = ""
    fileConverter = mdToKarax
    fileRemover = rmKarax
  runOnceOrWatch()

when isMainModule:
  # parse cmdline -w and
  import std/parseopt
  var mode = mOnce

  var p = commandLineParams().initOptParser(shortNoVal={'w'})
  while true:
    p.next()
    case p.kind:
    of cmdEnd: break
    of cmdShortOption, cmdLongOption:
      case p.key:
      of "w":
        mode = mWatch
        echo "going into watch mode"
      of ["h", "help"]:
        echo """
        build [OPTIONS]
        -w    run watcher
        """
        quit()
    of cmdArgument:
      echo "doesn't accept arguments"

  spawn runBuildJs(mode)
  spawn runBuildHtml(mode)
  spawn runPutAssets(mode)
  spawn runTranspileMarkdown(mode)

  if mode == mWatch:
    openDefaultBrowser "http://localhost:8080/#/"
  sync()
