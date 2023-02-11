import std/[os, strformat, strutils, times]
import nosey

when isMainModule:
  var 
    inPath, outPath: string
    lastBuildTime = getTime() - initDuration(seconds=2)

  proc updateBuild(sourceFilePath, targetDir: string) =
    if outPath != "" and 
      not outPath.startsWith "--out:":
      outPath = &"""--out:"{outPath}""""
    let
      cmd = &"nim js {outPath} {inPath}"
      now = getTime()
      durationSinceLastBuild = now - lastBuildTime
    if durationSinceLastBuild.inSeconds > 1:
      let errorCode = os.execShellCmd(cmd)
      lastBuildTime = now
      if errorCode != 0: quit(errorCode)

  # parse cmdline -w and/or -j=[file]
  import std/[parseopt, json]
  type Mode = enum mWatch, mOnce
  var
    sourceDir = "src"
    targetDir = "../dist"
    inFile = "website.nim"
    outFile = "app.js"
    jsonFile = ""
    mode = mOnce
  var p = commandLineParams().initOptParser(shortNoVal={'w'})
  while true:
    p.next()
    case p.kind:
      of cmdEnd: break
      of cmdShortOption, cmdLongOption:
        case p.key:
          of "o":
            if p.val != "":
              outPath = p.val
            echo "using out file " & p.val
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
            buildWatcher [OPTIONS] [FILE]
            [FILE]            default: {inFile}
            -o=[outFile]      default: {outFile}
            -s=[sourceDir]    default: {sourceDir}
            -t=[targetDir]    default: {targetDir}
            -j=[jsonFile]     default: {jsonFile}
            -w                run watcher
            """
            quit()
      of cmdArgument:
        if p.val != "":
          inPath = p.val
          break

  inPath = sourceDir/inFile
  outPath = targetDir/outFile

  # running
  case mode:
    of mWatch:
      watch(
        sourceDir,
        targetDir,
        1000,
        updateBuild,
        updateBuild,
        jsonFile,
        doNothingWhenNoJson=false
      )
    of mOnce:
      var 
        ss = DirState(dirName: sourceDir)
        ncd: NewChangedDeleted
      try:
        if jsonFile != "":
          ss = readFile(jsonFile).parseJson.to(ss.type) 
      except JsonParsingError, IOError:
        let e = getCurrentException()
        echo &"{e.name}: {e.msg}"
        echo "using current state of " & sourceDir & 
          " and creating " & jsonFile & " later"
        echo ""
      ncd = ss.updateDirState
      applyDirState(ss, targetDir, ncd, updateBuild, updateBuild)
      if jsonFile != "":
        writeFile(jsonFile.addFileExt("json"), $ %*ss)
