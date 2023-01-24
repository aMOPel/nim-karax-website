include karax / prelude

proc createDom*(): VNode =
  result = buildHtml(tdiv):
    h1:
      text "hi"
    p:
      text "whooo"


