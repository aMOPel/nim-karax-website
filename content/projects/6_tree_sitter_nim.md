[creationTime]:- "Feb 13. 2023"
[lastWriteTime]:- "Feb 21. 2023"

# tree-sitter-nim

<a href="https://github.com/aMOPel/tree-sitter-nim">
<img src="assets/icons8-github.svg" alt="GitHub" class="inline m-1 dark:invert">
GitHub</a>

This project is so far the best effort on GitHub to create 
a [Tree-Sitter](https://tree-sitter.github.io/tree-sitter/) grammar 
for the [Nim programming language](https://nim-lang.org/).

> Tree-Sitter is a parser generator tool and an incremental parsing library. 

Tree-Sitter is currently used by GitHub for syntax highlighting and static code analysis.
Also NeoVim uses it for similar things.

The Tree-Sitter CLI can generate a very fast C Parser from a rather simple JavaScript grammar file.

The work that I did in this project is in the `grammar.js` file and
in the `test/` folder, as well as in `src/scanner.cc`.

Development of a grammar is quite different from development of an application.
It is like implementing a standard: 
- There is a clearly defined goal you are working towards,
  and you can't do feature creep.
- However it also means an unfinished project is basically unusable.
  This is true especially for a parser, since it stops working correctly,
  when it can't identify all syntax elements.

I spent a lot of time on this project,
probably more than on any other project in
my list.
Still, the grammar is **incomplete**.

This came down to multiple subproblems:

**First:** Nim has a really **flexible syntax**, which makes for a great
developing experience, but that also makes parsing it a difficult problem.
On top of that, the tree-sitter grammar system wasn't built for indentation based
languages.
It is still doable to parse indentation by implementing it yourself in C++.
However this also has its limitations.

**Second:** In the case of Nim there is 
an [official Grammar](https://nim-lang.github.io/Nim/manual.html#syntax-grammar) description 
in [EBNF](https://en.wikipedia.org/wiki/Extended_Backus–Naur_form).
This documentation helped me get into the grammar development,
but I ultimately found it was **not entirely accurate**,
which meant I had to manually check the actual limits of the syntax.

**Third:** This project was built with a **heavy emphasis on tests**.
This was necessary, because the grammar quickly becomes a complex system,
in which small changes can have unexpected effects on other parts in the system.
Thus a lot of test cases are necessary to prevent regression.
This becomes more and more important the bigger the grammar grows, making
the final pieces the hardest to fit into this net of interactions.

**Fourth:** This growing complexity and seeming halt in 
progression **frustrated and demotivated** me.
In the end I did **not spend enough time** to 
solve the last problems mentioned in the issues on the GitHub repo.
