include karax / prelude
# import ../content/test/test
import website/contentCollection

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
  result = buildHtml(tdiv):
    buildMenu(@[kstring"one", kstring"two"])
    text "hi"
    for bla in contents:
      bla.content()

setRenderer website.createDom
