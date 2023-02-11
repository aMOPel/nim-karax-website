include karax / prelude

proc createDom*(): VNode =
  result = buildHtml(article):
    h1:
      text "tasketeer.nim"
    a(href = "https://github.com/aMOPel/tasketeer.nim"):
      img(src = "icons8-github.svg", class = "inline m-1", alt = "GitHub")
      text "GitHub"
    p:
      text "Tasketeer is a prototype of a To-Do App made with "
      a(href = "https://nim-lang.org/"):
        text "Nim"
      text "."
    p:
      text """
The goal of this project was mainly to play around with architecture. I settled
on the following:"""
    p:
      text """
The data is saved through a dynamic library interface. I only implemented a
SQLite backend using an ORM library, however it is possible to write another
dynamic library that plugs into the same interface, which uses another storage
solution."""
    p:
      text """
The frontend was also constructed in a way to support multiple frontend
solutions, like web. I only implemented a CLI, though. Also the frontend was
basically split into input (CLI) and output (print to stdout)."""
    p:
      text """
Only a good while later after revisiting the MVC pattern I realized that part of
this architecture is basically MVC."""
    p:
      text """
Another part of the architecture was, that it is possible to choose the backend
dynamic library in a configuration file. That wasn't really possible for the
frontend since it is compiled into the binary. In hindsight, I wonder if a
dynamic library interface would have also been sensible for the frontend."""
    p:
      text """
Also this turned out to be an exercise in error handling, as faults in the user
input and backend had to be handled properly."""


