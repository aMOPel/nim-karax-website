include karax / prelude

proc createDom*(): VNode =
  result = buildHtml(tdiv):
    p(id="timestamp"): text "last updated 30-01-2023 22:44"
    h1:
      text "aMOPel's Qualifications"
    p:
      text "Welcome! This website is a display of my programming experiences so far"


