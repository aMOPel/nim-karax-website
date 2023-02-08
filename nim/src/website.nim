include karax / prelude
# import ../content/test/test
import website/[globals, index, menu, dates]
import std/[strformat]


var
  kxi: KaraxInstance

proc createDom(route: RouterData): VNode =
  var content: VNode
  for c in articleContents:
    if route.hashPart == &"#/{c.name}":
      content = c.content()
      content.insert(c.buildDates, 0)
      # content.getVNodeById("timestamp").class &= "text-sm italic"
      break
    elif route.hashPart == "#/index":
      content = kxi.buildIndex
    elif route.hashPart == "#/experience":
      content = experienceContent.content()
    elif route.hashPart.`$` in ["#/", "", "#/home"]:
      content = homeContent.content()
      # content.getVNodeById("timestamp").class &= "text-sm italic"
      break

  content.class &= """ 
    prose dark:prose-invert
    w-full max-w-3xl p-10 mx-auto 
    bg-grey dark:bg-dmgrey
    border-x-darkgrey dark:border-x-dmdarkgrey border-x-4
    border-b-darkgrey dark:border-b-dmdarkgrey border-b-4
    rounded-b-xl
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

when isMainModule:

  kxi = setRenderer website.createDom
