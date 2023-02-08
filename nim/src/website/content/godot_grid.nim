include karax / prelude

proc createDom*(): VNode =
  result = buildHtml(article):
    h1:
      text "godot-grid"
    a(href = "https://github.com/aMOPel/godot-grid"):
      img(src = "icons8-github.svg", class = "inline m-1", alt = "GitHub")
      text "GitHub"
    p:
      text "This is a utility library for the "
      a(href = "https://godotengine.org/"):
        text "Godot Game Engine"
      text ", written in GDScript."
    p:
      text "It makes use of my other Godot library "
      a(href = "#/godot_exchange_scene"):
        text "godot-exchange-scene"
      text "."
    p:
      text "The goal was to provide numerous utilities for working with rectangular grids."
    p:
      text """
This project came to be, because I was writing a Tetris clone with Godot. Then
it grew a little bigger afterwards as I grew more interested in the topic."""
    p:
      text """
Overall it was a fun exercise, but taught me the limits of GDScript and its
performance, as I tried to test out the limits of this library."""


