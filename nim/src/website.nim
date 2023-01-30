include karax / prelude
# import ../content/test/test
import website/contentCollection
import std/[strformat]

var homeContent: VNode

proc menuAction(menuEntry: kstring): proc() =
  result = proc() =
    echo "clicked ", menuEntry

proc buildMenu(menu: openArray[tuple[text: string, href: string]]): VNode =
  result = buildHtml(tdiv(class="""
    bg-[#fff] max-w-3xl w-full mx-auto sticky top-0 p-3
  """)):
    # border-x-red border-x-4
    nav(class="flex"):
      for (t, href) in menu:
        tdiv(class="""
        mr-3
        h-9 w-14 min-h-fit min-w-fit
        bg-white
        border-b-2 border-b-black rounded-sm 
        text-lg text-black font-bold
        relative
        """):
          p(class="""
          invisible text-xl h-0
          """): 
            text t
          a(class="""
            absolute top-1/2 left-1/2
            -translate-x-1/2 -translate-y-1/2
            hover:text-red hover:text-xl
          """, href = &"#/{href}"):
            text t

proc createDom(route: RouterData): VNode =
  var content: VNode
  for c in contents:
    if route.hashPart == &"#/{c.name}":
      content = c.content()
      break
    elif route.hashPart == &"#/":
      content = homeContent
      break

  content.class &= """ 
    prose w-full bg-white mx-auto p-10 max-w-3xl 
    border-x-red border-x-4
  """
  result = buildHtml(tdiv(class="""
                          """)):
    buildMenu({"Home": "", "Index": "index"})
    if not content.isNil:
      content

var tempI: int
for i, c in contents.pairs:
  if c.name == "home":
    homeContent = c.content()
    tempI = i
contents.delete tempI

setRenderer website.createDom
