import pkg/karax/[vdom, karaxdsl]

proc createDom*(): VNode =
  result = buildHtml(article):
    h1:
      text "godot-tetris-clone"
    a(href = "https://github.com/aMOPel/godot-tetris-clone"):
      img(src = "assets/icons8-github.svg", class = "inline m-1 dark:invert", alt = "GitHub")
      text "GitHub"
    p:
      text "A simple Tetris clone made with the "
      a(href = "https://godotengine.org/"):
        text "Godot Game Engine"
      text "."
    p:
      img(src = "assets/tetris_in_game.png", alt = "Tetris In Game")
    p:
      text "It uses my other 2 Godot projects: "
      a(href = "#/godot_exchange_scene"):
        text "godot-exchange-scene"
      text " and "
      a(href = "#/godot_grid"):
        text "godot-grid"
      text "."
    p:
      text """
This is the only real game I've made with Godot so far. I am planning on more,
though."""
    p:
      text """
It took me a little while, and I didn't even implement the so-called "super
rotation system", which allows for tiles to be rotated into narrow spaces,
despite the way there being blocked."""
    p:
      text """
However it was a fun project for sure, and it gave me an insight into some
intricacies of Godot and game development in general. Suffice it to say: gamedev
is quite involved and requires the mastery of a lot of disciplines."""


