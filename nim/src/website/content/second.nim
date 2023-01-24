include karax / prelude

proc createDom*(): VNode =
  result = buildHtml(tdiv):
    h1:
      text "this is also"
    p:
      text "a header"
      img(src = "cat.png", alt = "cat")


