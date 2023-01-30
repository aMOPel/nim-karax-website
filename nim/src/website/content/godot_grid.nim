include karax / prelude

proc createDom*(): VNode =
  result = buildHtml(tdiv):
    p(id="timestamp"): text "last updated 30-01-2023 22:44"
    h1:
      a(href = "https://github.com/aMOPel/godot-grid"):
        text "godot-grid"
    p:
      text "This is a utility library for the "
      a(href = "https://godotengine.org/"):
        text "Godot Game Engine"
      text ", written in gdscript."
    p:
      text "It makes use of my other godot library "
      a(href = "#/godot_exchange_scene"):
        text "godot-exchange-scene"
      text "."
    p:
      text "The goal was to provide numerous utilities for working with rectangular grids."
    p:
      text """
This project came to be, because I was writing a tetris clone with Godot. Then
it grew a little bigger afterwards as I grew more interested in the topic."""
    p:
      text """
Overall it was a fun excercise, but taught me the limits of gdscript and its
performance, as I tried to test out the limits of this library."""


