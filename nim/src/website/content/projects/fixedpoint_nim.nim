import pkg/karax/[vdom, karaxdsl]

proc createDom*(): VNode =
  result = buildHtml(article):
    h1:
      text "fixedpoint.nim"
    a(href = "https://github.com/aMOPel/fixedpoint.nim"):
      img(src = "assets/icons8-github.svg", class = "inline m-1", alt = "GitHub")
      text "GitHub"
    p:
      text "This project was an exercise with the goal of creating a "
      a(href = "https://en.wikipedia.org/wiki/Fixed-point_arithmetic"):
        text "fixed-point"
      text " data type."
    p:
      text "It is implemented in "
      a(href = "https://nim-lang.org/"):
        text "Nim"
      text "."
    p:
      text """
This Nim library however doesn't work on a bit-level and is thus not based on
the binary number system but on the decimal number system. This means it isn't
as fast however it is quite easy to use (and to implement)."""
    p:
      text """
The only real application for this library would be if you work with numbers
that only have a limited amount of decimal places, like money."""
    p:
      text "In such cases the following problem can arise:"
    pre:
      code(class = "language-nim"):
        text """let
  a = 0.566
  b = 0.466
  c = a + b
echo &"{a.round(2)} + {b.round(2)} = {c.round(2)}"
# 0.57 + 0.47 = 1.03
# doesn't add up
# instead you would need to round your floats everywhere before you operate on them
# (in fact that is more or less what this lib is doing)
"""
    p:
      text "This problem could be circumvented with this library."
    p:
      text "After writing it, I have to admit it's not too useful, though."


