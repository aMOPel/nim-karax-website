import pkg/karax/[vdom, karaxdsl]

proc createDom*(): VNode =
  result = buildHtml(article):
    h1:
      text "Experience"
    a(href = "https://github.com/aMOPel"):
      img(src = "assets/icons8-github.svg", class = "inline m-1 dark:invert", alt = "GitHub")
      text "GitHub Profile"
    p:
      text "My experience gathered in programming related fields so far."
    h2:
      text "Programming languages"
    h3:
      text "Nim"
    p:
      text "About two years ago I discovered a less known language called "
      a(href = "https://nim-lang.org/"):
        text "Nim"
      text """
, that seemed very exciting at first and managed to remain exciting. That is why
most of my more recent projects use it in some capacity. Like when I was
learning C++, learning Nim in depth gave me some deeper insights into software
engineering concepts like meta programming and garbage collection."""
    h3:
      text "JavaScript/TypeScript (and HTML+CSS)"
    p:
      text """
I had no real contact with JavaScript throughout my studies, but I had to get
into it, when I helped with a Vue project. It wasn't very hard, due to my
knowledge of the previously learned languages. Of course, I also had to refresh
my knowledge of HTML and CSS, which I was already somewhat familiar with.
Although I am familiar with most concepts surrounding web development, I am
still missing many of the details necessary."""
    h3:
      text "C++"
    p:
      text """
I took a computer graphics course, which required writing C++, which turned out
to be not as hard as I thought. A while later I worked through """
      a(href = "https://www.learncpp.com/"):
        text "learncpp.com"
      text """
, which gave me a much better grasp of types, pointers, references, passing by
value/reference, compile time vs runtime, stack vs heap, and some other software
engineering concepts, that I hadn't really understood before."""
    h3:
      text "Python"
    p:
      text "During my studies I had to learn more about Python and thus I read most of the "
      a(href = "https://docs.python.org/3/tutorial/index.html"):
        text "official tutorial"
      text """
 back then. I haven't written a lot of Python since those days, except for in my
bachelor thesis. However I still enjoy it due to its concise syntax and extreme
flexibility in use cases."""
    h3:
      text "SQL"
    p:
      text """
I took various database courses, some of which included practical usage of
PostgreSQL. I haven't used SQL a lot since then. It only came to use, in my """
      a(href = "#/tasketeer_nim"):
        text "tasketeer.nim"
      text """
 project. In there I used SQLite and an ORM library. However I found that I
still felt quite comfortable writing SQL Queries."""
    h3:
      text "Java"
    p:
      text """
In the first semesters of my studies I had to use some Java for various
exercises. I haven't really used it since, so my Java knowledge is extremely
rusty."""
    h2:
      text "Frameworks"
    p:
      text """
Other than Godot and (a little) Vue I haven't really explored bigger Frameworks,
since I didn't really do projects of bigger scale yet."""
    h2:
      text "Other Technologies"
    h3:
      text "Linux Terminal"
    p:
      text """
Probably the most noteworthy technology I am familiar with is the terminal
environment on Linux. Due to my terminal focused workflow, and a few years of
experience I am well versed with the user level aspects."""
    h3:
      text "Git"
    p:
      text """
Git has been my VCS of choice for a long time now and as you can see on my
GitHub profile I am also familiar with the GitHub additions to the Git workflow,
namely working with Issues and PRs. I didn't use GitHub actions yet, however
build scripts I use build scripts for building and more regularly."""
    h3:
      text "Docker"
    p:
      text """
During my studies I also had to use a few docker containers, so I at least have
a superficial understanding of its usage."""
    h2:
      text "Tooling"
    p:
      text """
Since I spent a lot of time learning and configuring Vim/NeoVim and other tools
in the terminal, I have a decent understanding of the development tool domain."""
    p:
      text "Among others, I came in contact with:"
    ul:
      li:
        text "LSP Servers, which are usually responsible for"
        ul:
          li:
            text "Linting and Code Actions"
          li:
            text "Providing completion items"
          li:
            text "Formatting (some)"
          li:
            text "Intelligent Code Navigation like \"go to definition\" / \"go to references\""
      li:
        text """
Syntax Highlighting (In NeoVim mostly done by Tree-Sitter, but also by RegEx
Grammars)"""
      li:
        text "Debug Adapters (mostly DAP)"
      li:
        text "Snippet Engines"
      li:
        text """
Grep-likes, RegEx/Globbing and fuzzy finders for efficient searching and
replacing"""
      li:
        text "Scripting for building/deploying (in "
        code:
          text "sh"
        text " or some programming language)"


