import std/[strutils, sequtils]
import pkg/karax/[vdom, karaxdsl, karax, kdom]
# import ../content/test/test
import website/[globals, projectIndex, menu, dates]

var
  kxi: KaraxInstance

proc createDom(route: RouterData): VNode =
  # add project index to menu
  contents["menu"]["open_source_projects"] = Content(
    index: 100,
    subDir: "menu",
    name: "open_source_projects",
    content: buildProjectIndex,
  )

  var
    content: VNode
  currentRoute = route.hashPart.`$`
  currentRoute.removePrefix "#/"

  # routing
  var found = false
  for contentSub in contents.keys:
    if currentRoute in contents[contentSub].keys.toSeq:
      let current = contents[contentSub][currentRoute]
      content = current.content()
      let dates = current.buildDates
      if dates != nil: content.insert(dates, 0)
      found = true
      break
  if not found:
    window.location.href = "#/home"
    window.location.reload

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
    buildMenu(contents["menu"].keys.toSeq)
    if not content.isNil:
      content

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
