import pkg/karax/[vdom, karaxdsl]

proc createDom*(): VNode =
  result = buildHtml(article):
    h1:
      text "tree-sitter-nim"
    a(href = "https://github.com/aMOPel/tree-sitter-nim"):
      img(src = "assets/icons8-github.svg", class = "inline m-1 dark:invert", alt = "GitHub")
      text "GitHub"
    p:
      text "This project is so far the best effort on GitHub to create a "
      a(href = "https://tree-sitter.github.io/tree-sitter/"):
        text "Tree-Sitter"
      text " grammar for the "
      a(href = "https://nim-lang.org/"):
        text "Nim programming language"
      text "."
    blockquote:
      p:
        text "Tree-Sitter is a parser generator tool and an incremental parsing library."
    p:
      text """
It is currently used by GitHub for syntax highlighting and static code analysis.
Also NeoVim uses it for similar things."""
    p:
      text """
The Tree-Sitter CLI can generate a very fast C Parser from a rather simple
JavaScript grammar file."""
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


