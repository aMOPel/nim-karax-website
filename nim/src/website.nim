include karax / prelude
# import ../content/test/test
import website/[globals, index, menu, dates]
import std/[strformat]

# TODO: find a solution for meta data in head html and karun not allowing for that

var
  kxi: KaraxInstance

proc createDom(route: RouterData): VNode =
  var content: VNode
  if route.hashPart == "#/index":
    content = kxi.buildIndex
  elif route.hashPart == "#/experience":
    content = contents["special"]["experience"].content()
  elif route.hashPart.`$` in ["#/", "", "#/home"]:
    content = contents["special"]["home"].content()
  else:
    for name, c in contents["projects"]:
      if route.hashPart == &"#/{name}":
        content = c.content()
        content.insert(c.buildDates, 0)
        break

  content.id = "content"
  content.class &= """ 
    prose dark:prose-invert
    w-full max-w-3xl p-10 mx-auto 
    bg-grey dark:bg-dmgrey
    md:border-x-darkgrey md:dark:border-x-dmdarkgrey md:border-x-4
    border-b-darkgrey dark:border-b-dmdarkgrey border-b-4
    md:rounded-b-xl
  """
  result = buildHtml(tdiv(
    class="""
      bg-white
      dark:bg-dmwhite
      min-h-screen
    """)):
    kxi.buildMenu({"Home": "home", "General Experience": "experience", "Project Index": "index"})
    if not content.isNil:
      content

import karax/kdom
proc highlight(elem: Element) {.importjs: "hljs.highlightElement(#)".}
proc postRender(routerDate: RouterData) =
  for elem in document.querySelectorAll("pre code"):
    if elem.getAttribute("hljs-rendered") != "true":
      highlight(elem)
      elem.setAttribute("hljs-rendered", "true")

when isMainModule:
  kxi = setRenderer(website.createDom, clientPostRenderCallback=postRender)
  setForeignNodeId "content", kxi
