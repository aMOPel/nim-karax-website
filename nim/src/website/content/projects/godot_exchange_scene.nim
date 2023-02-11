include karax / prelude

proc createDom*(): VNode =
  result = buildHtml(article):
    h1:
      text "godot-exchange-scene"
    a(href = "https://github.com/aMOPel/godot-xchange-scene"):
      img(src = "assets/icons8-github.svg", class = "inline m-1", alt = "GitHub")
      text "GitHub"
    p:
      text "This is a utility library for the "
      a(href = "https://godotengine.org/"):
        text "Godot Game Engine"
      text ", written in GDScript."
    p:
      text """
The use case is very specific to the Godot engine, so I'm not going to get into
that."""
    p:
      text """
GDScript is the custom scripting language of the Godot engine. It resembles
Python in some aspects, but overall it is very simplistic."""
    p:
      text """
This project was probably my first real experience of writing a slightly bigger
project and making it available to the public. This entailed that I had to
document and test my code, which probably took more time than writing the actual
code, but significantly improved the code quality, since it revealed several
bugs and issues."""


