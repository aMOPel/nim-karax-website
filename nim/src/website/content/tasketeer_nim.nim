include karax / prelude

proc createDom*(): VNode =
  result = buildHtml(tdiv):
    p(id="timestamp"): text "last updated 30-01-2023 22:44"
    h1:
      a(href = "https://github.com/aMOPel/tasketeer.nim"):
        text "tasketeer.nim"
    p:
      text "Tasketeer is a prototype of a todo app made with "
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
basically split into input (cli) and output (print to stdout)."""
    p:
      text """
Only a good while later after revisiting the MVC pattern I realized that part of
this architecture is basically MVC."""
    p:
      text """
Another part of the architecture was, that it is possible to choose the backend
dynamic library in a config file. That wasn't really possible for the frontend
since it is compiled into the binary. In hindsight, I wonder if a dynamic
library interface would have also been sensible for the frontend."""
    p:
      text """
Also this turned out to be an excercise in error handling, as faults in the user
input and backend had to be handled properly."""


