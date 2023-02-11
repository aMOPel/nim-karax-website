import std/[os, strformat]
import nosey

when isMainModule:
  # parse cmdline -w and/or -j=[file]
  import std/[parseopt, json]
  type Mode = enum mWatch, mOnce
  var
    sourceDir = "assets"
    targetDir = "../dist/assets"
    jsonFile = ""
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
            echo &"""
            -s=[sourceDir]    default: {sourceDir}
            -t=[targetDir]    default: {targetDir}
            -j=[jsonFile]     default: {jsonFile}
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
        1000,
        defaultFileConverter,
        defaultFileRemover,
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
      applyDirState(ss, targetDir, ncd, defaultFileConverter, defaultFileRemover)
      if jsonFile != "":
        writeFile(jsonFile.addFileExt("json"), $ %*ss)
