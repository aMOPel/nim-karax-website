include karax / prelude

proc createDom*(): VNode =
  result = buildHtml(article):
    h1:
      text "This Website"
    a(href = "https://github.com/aMOPel/nim-karax-website"):
      img(src = "icons8-github.svg", class = "inline m-1", alt = "GitHub")
      text "GitHub"
    p:
      text """
This very website is a Single Page Application using transpiled Markdown as a
source of content."""
    p:
      text "It was build using "
      a(href = "https://nim-lang.org/"):
        text "Nim"
      text ", "
      a(href = "https://github.com/karaxnim/karax"):
        text "Karax"
      text " and "
      a(href = "https://tailwindcss.com/"):
        text "TailwindCSS"
      text "."
    p:
      text """
Among other things, Karax provides a DSL in Nim to describe HTML. This allows
for describing the HTML layout intermingled with the imperative code. A concept
somewhat similar to Vue's concepts of template syntax, conditional rendering
etc. Only in Vue it's about inserting functionality into HTML, but in Karax it's
about generating HTML using a programming language."""
    p:
      text """
The Nim code can be compiled to a SPA JavaScript file, which renders the whole
website."""
    p:
      text """
On top of that, the Tailwind utility classes can be written directly into the
Karax HTML tags. Tailwind is not strictly necessary to apply style to the tags,
since the tags also have a mutable """
      code:
        text "style"
      text """
 attribute, however Tailwind makes the application of the styles a little
simpler."""
    p:
      text """
The resulting project structure is quite interesting, as every aspect of the
website can be described in Nim and manipulated using it."""
    p:
      text """
The different parts of the website can be split up into reusable components
(which are just functions in this case) and separated into modules, also similar
to Vue."""
    p:
      text """
This structure however is completely orthogonal to the often advertised
"separation of concerns". Instead of ordering Code by concerns (layout, style,
functionality), it can be ordered by components, in which the concerns are mixed
and matched as needed."""
    p:
      text "Example:"
    p:
      em:
        text "The menu component with collapsed Tailwind classes:"
    pre:
      code(class = "language-nim"):
        text """proc buildMenu*(
  kxi: KaraxInstance,
  menu: openArray[tuple[text: string, href: string]]
): VNode =
  result = buildHtml(nav(class="...")):
    ul(class="..."):
      for (t, href) in menu:
        li(class="..."):
          a(class="...", href = &"#/{href}", onclick=kxi.onClickRedraw):
            text t
"""
    p:
      text """
Since the Tailwind classes are just strings in Nim, they can be composed in any
way desired, using string manipulation."""
    p:
      text """
The benefit over Vue would be that there is no necessity for a separate file
format like """
      code:
        text ".vue"
      text """
 and resulting tooling issues, like completion, linting, formatting,
highlighting etc."""
    p:
      text """
A downside is of course, that Nim's ecosystem is inferior to JavaScript's, in
terms of libraries, documentation and support, due to the big difference in user
base size."""
    hr()
    p:
      text "Also notable, apart from the architecture, is the content management."
    p:
      text "Using my file watcher "
      a(href = "#/nosey"):
        text "nosey"
      text """
, Markdown files get transpiled to the Karax DSL. That Nim code can then be
imported and integrated into the website as desired."""
    p:
      text """
For example, this website is using the file names of the Markdown files as
routes for which the content will be the content of the Markdown file."""

