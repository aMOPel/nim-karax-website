include karax / prelude

proc createDom*(): VNode =
  result = buildHtml(tdiv):
    p(id="timestamp"): text "last updated 30-01-2023 22:44"
    h1:
      a(href = "https://github.com/aMOPel/tree-sitter-nim"):
        text "tree-sitter-nim"
    blockquote:
      p:
        a(href = "https://tree-sitter.github.io/tree-sitter/"):
          text "Tree-Sitter"
        text " Tree-sitter is a parser generator tool and an incremental parsing library."
    p:
      text """
It is currently used by GitHub for syntax highlighting and static code analysis.
Also NeoVim uses it for similar things."""
    p:
      text """
The Tree-Sitter CLI can generate a very fast C Parser from a rather simple JS
grammar file."""
    p:
      text """
This project is so far the best effort on GitHub to create a Tree-Sitter grammar
for the """
      a(href = "https://nim-lang.org/"):
        text "Nim programming language"
      text "."
    p:
      text "The actual work that I did is in the "
      code:
        text "grammar.js"
      text " file and in the "
      code:
        text "test"
      text " folder."
    p:
      text """
Sadly the grammar is still not quite complete as the Nim syntax is quite
complex, and I didn't spend enough time to solve the last problems mentioned in
the issues on the GitHub repo."""


