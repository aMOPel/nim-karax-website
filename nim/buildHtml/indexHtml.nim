import std/[os, htmlgen]
import styleSheetsHtml, jsScriptsBodyHtml, jsScriptsHeadHtml, metaDataHtml

var filePath = "index.html"

var index = 
  html(
    head(
      title("aMOPel's Experience"),
      meta(charset="UTF-8"),
      meta(content="width=device-width, initial-scale=1", name="viewport"),
      metaData,
      link(href="styles.css", rel="stylesheet", type="text/css"),
      styleSheets,
      jsScriptsHead,
    ),
    body( id="body", class="site",
         `div`(id="ROOT"),
      script(type="text/javascript", src="app.js"),
      jsScriptsBody,
    )
  )

when isMainModule:
  import std/parseopt

  var p = commandLineParams().initOptParser()
  while true:
    p.next()
    case p.kind:
      of cmdEnd: break
      of cmdShortOption, cmdLongOption:
        case p.key:
        of ["h", "help"]:
          echo """
          indexHtml [FILE]
          """
          quit()
      of cmdArgument:
        filePath = p.key

  filePath.writeFile "<!DOCTYPE html> " & index
