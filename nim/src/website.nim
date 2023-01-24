include karax / prelude
# import ../content/test/test
import website/contentCollection
import std/[strformat]

proc menuAction(menuEntry: kstring): proc() =
  result = proc() =
    echo "clicked ", menuEntry

proc buildMenu(menu: seq[kstring]): VNode =
  result = buildHtml(tdiv):
    for m in menu:
      nav(class="navbar is-primary"):
        tdiv(class="navbar-brand"):
          a(class="navbar-item", onclick = menuAction(m)):
            text m

proc createDom(route: RouterData): VNode =
  var content: VNode
  for c in contents:
    if route.hashPart == &"#/{c.name}":
      content = c.content()
      break

  result = buildHtml(tdiv(class="border-4 border-solid border-amber-200 rounded-md w-20")):
    buildMenu(@[kstring"one", kstring"two"])
    text "hi"
    button(class="button"):
      text "click me"
    # img(src="cat.png")
    if not content.isNil:
      content

setRenderer website.createDom
