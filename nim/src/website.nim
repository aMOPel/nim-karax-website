import pkg/karax/[vdom, karaxdsl, karax, kbase]
# import ../content/test/test
import website/[globals, index, menu, dates]

var
  kxi: KaraxInstance

proc createDom(route: RouterData): VNode =
  var content: VNode
  if route.hashPart == "#/index":
    content = buildIndex()
  elif route.hashPart == "#/about_me":
    content = contents["special"]["about_me"].content()
  elif route.hashPart == "#/experience":
    content = contents["special"]["experience"].content()
    content.insert(contents["special"]["experience"].buildDates, 0)
  elif route.hashPart.`$` in ["#/", "", "#/home"]:
    content = contents["special"]["home"].content()
  else:
    for name, c in contents["projects"]:
      if route.hashPart == kstring("#/" & name):
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
    buildMenu({
      "Home": "home",
      "About Me": "about_me",
      "General Experience": "experience",
      "Open Source Projects": "index",
    })
    if not content.isNil:
      content

import karax/kdom
const
  hljsLightTheme = "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/styles/base16/atelier-dune-light.min.css"
  hljsDarkTheme = "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/styles/base16/atelier-dune.min.css"
proc highlight(elem: Element) {.importjs: "hljs.highlightElement(#)".}
proc darkMode(): bool {.importjs: "window.matchMedia('(prefers-color-scheme: dark)').matches".}
proc replaceHeadLink(id, href: string) =
  var 
    head = document.querySelector("head")
    oldLink = document.getElementById(id)
    newLink = document.createElement("link")
  newLink.setAttr("rel", "stylesheet")
  newLink.setAttr("id", id)
  newLink.setAttr("href", href)
  if oldLink.isNil:
    head.appendChild newLink
  else:
    head.replaceChild(newLink, oldLink)

proc postRender(routerDate: RouterData) =
  window.scrollTo(0,0)
  for elem in document.querySelectorAll("pre code"):
    if elem.getAttribute("hljs-rendered") != "true":
      highlight(elem)
      elem.setAttribute("hljs-rendered", "true")
  if darkMode(): replaceHeadLink("hljs-theme", hljsDarkTheme)
  else: replaceHeadLink("hljs-theme", hljsLightTheme)


when isMainModule:
  kxi = setRenderer(website.createDom, clientPostRenderCallback=postRender)
  setForeignNodeId "content", kxi
