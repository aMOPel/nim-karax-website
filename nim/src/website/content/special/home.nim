import pkg/karax/[vdom, karaxdsl]

proc createDom*(): VNode =
  result = buildHtml(article):
    h1:
      text "aMOPel's Experience"
    p:
      text "Welcome! This website is a display of my programming experiences so far."
    ul:
      li:
        a(href = "#/experience"):
          text "General Experience"
        text " to read about my general programming experience in various fields"
      li:
        a(href = "#/index"):
          text "Project Index"
        text " to read about my Open Source projects."


