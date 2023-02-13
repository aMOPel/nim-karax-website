import std/htmlgen

var jsScriptsHead* = 
  script(
    src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/highlight.min.js"
  ) &
  script(
    src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/languages/nim.min.js"
  )
