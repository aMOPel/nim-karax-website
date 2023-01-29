# [tree-sitter-nim](https://github.com/aMOPel/tree-sitter-nim)

> [Tree-Sitter](https://tree-sitter.github.io/tree-sitter/) Tree-sitter is a parser generator tool and an incremental parsing library. 

It is currently used by GitHub for syntax highlighting and static code analysis.
Also NeoVim uses it for similar things.

The Tree-Sitter CLI can generate a very fast C Parser from a rather simple JS grammar file.

This project is so far the best effort on GitHub to create a Tree-Sitter grammar 
for the [Nim programming language](https://nim-lang.org/).

The actual work that I did is in the `grammar.js` file and in the `test` folder.

Sadly the grammar is still not quite complete as the Nim syntax is quite complex,
and I didn't spend enough time to solve the last problems mentioned in the issues on the GitHub repo.

