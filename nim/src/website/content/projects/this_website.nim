import pkg/karax/[vdom, karaxdsl]

proc createDom*(): VNode =
  result = buildHtml(article):
    h1:
      text "This Website"
    a(href = "https://github.com/aMOPel/nim-karax-website/tree/amopels_content"):
      img(src = "assets/icons8-github.svg", class = "inline m-1 dark:invert", alt = "GitHub")
      text "GitHub"
    p:
      text """
This very website is a SPA (single page application) using transpiled Markdown
as a source of content."""
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
    h2:
      text "Architecture"
    h3:
      text "Functionality and Layout"
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
The static HTML file, that the SPA JavaScript file is embedded in, is also
generated using Nim. This enables imperative composition of all metadata,
(external) stylesheets and scripts that may be put anywhere in the static HTML."""
    h3:
      text "Styles"
    p:
      text """
On top of that, the Tailwind utility classes can be written directly into the
Karax HTML tags. Tailwind is not strictly necessary to apply style directly to
the tags, since the tags also have a mutable """
      code:
        text "style"
      text """
 attribute, however Tailwind makes the application of the styles a little
simpler."""
    p:
      strong:
        text "Bonus:"
      text """
 Since the Tailwind classes are just strings in Nim, they can be composed in any
way desired, using string manipulation."""
    h3:
      text "Fusion Of Concerns?"
    p:
      text """
This project structure is quite interesting, as every aspect of the website can
be described in Nim and manipulated using it."""
    p:
      text """
The different parts of the website can be split up into reusable components
(which are just functions in this case) and separated into modules, also similar
to Vue."""
    p:
      text """
This structure is the antithesis to the often advertised "separation of
concerns". Instead of ordering Code by concerns (layout, style, functionality),
it can be ordered by components, in which the concerns are mixed and matched as
needed."""
    p:
      text "Example:"
    p:
      em:
        text "The menu component with collapsed Tailwind classes:"
    pre:
      code(class = "language-nim"):
        text """proc buildMenu*(menu: openArray[MenuItem]): VNode =
  if clientWidth() < mobileMenuWidthThreshold:
    result = buildMobileMenu(menu) # different component
  else:
    result = buildHtml(nav(class="...")):
      ul(class="..."):
        for (t, href) in menu:
          li(class="..."):
            a(class="...", href=kstring("#/" & href)):
              text t
"""
    h3:
      text "Content Management"
    p:
      text "Also notable, is the content management."
    p:
      text """
Using a Markdown-To-HTML Converter and a HTML-To-KaraxDSL Converter, Markdown
files get transpiled to the Karax DSL. That Nim code can then be imported and
integrated into the website as desired."""
    p:
      text """
For example, this website is using the file names of the Markdown files as
routes for which the content of the body will be the content of the Markdown
file."""
    p:
      text "E.g. for this article the route is "
      code:
        text "/this_website"
      text " so its content is generated from a Markdown file named "
      code:
        text "this_website.md"
      text "."
    h2:
      text "Build Process"
    p:
      text "A Nim build script takes care of"
    ol:
      li:
        text "transpiling the content to KaraxDSL,"
      li:
        text "compiling the Karax website to JavaScript,"
      li:
        text "generating the static HTML from Nim code and"
      li:
        text "placing all those and the assets in the "
        code:
          text "build/"
        text " directory"
    p:
      text "This can either be once, or continuously, using my file watcher "
      a(href = "#/nosey_nim"):
        text "nosey.nim"
      text "."
    p:
      text "Additionally the "
      code:
        text "styles.css"
      text " needs to be generated by the Tailwind CLI."
    p:
      text "When deploying, another script is used to minify all the files in the "
      code:
        text "build/"
      text "directory, using "
      code:
        text "uglify-js"
      text ", "
      code:
        text "cssnano"
      text ", "
      code:
        text "html-minifier"
      text " and "
      code:
        text "imagemin"
      text ". The minified files are then placed in the "
      code:
        text "dist/"
      text " directory."
    h2:
      text "Features"
    h3:
      text "Syntax Highlighting"
    p:
      text "Ordinarily it's not a big deal to throw in a "
      code:
        text "highlight.js"
      text """
 import in the head of the HTML. However with SPAs it's not that simple, since
the HTML doesn't get sent anew by the server but is mutated on client-side. Thus """
      code:
        text "highlight.js"
      text """
 needs to be invoked on every redraw to update the code block classes. Luckily
Nim's excellent FFI (foreign function interface) makes it quite easy to invoke
external JavaScript functions, while staying in Nim."""
    pre:
      code(class = "language-nim"):
        text """# using ffi to invoke external js code
proc highlight(elem: Element) {.importjs: "hljs.highlightElement(#)".}

# the post render callback
proc postRender(routerDate: RouterData) =
  for elem in document.querySelectorAll("pre code"):
    highlight(elem)
"""
    h3:
      text "Dark Mode"
    p:
      text "Using Tailwinds "
      code:
        text "dark:"
      text " variant it's effortless to change styles, based on"
      code:
        text "prefers-color-scheme"
      text """
. This website uses a simple color palette and simply swaps light and dark
colors for dark mode. Additionally the black icons get inverted."""
    p:
      text "However, to accommodate 2 different "
      code:
        text "highlight.js"
      text " themes, it was necessary to use some code again."
    pre:
      code(class = "language-nim"):
        text """proc darkMode(): bool {.importjs: "window.matchMedia('(prefers-color-scheme: dark)').matches".}

proc replaceHeadLink(href: string) =
  # swaps out one stylesheet link for another

proc postRender(routerDate: RouterData) =
  if darkMode(): replaceHeadLink(hljsDarkTheme)
  else: replaceHeadLink(hljsLightTheme)
"""
    h3:
      text "Responsive Design"
    p:
      text "With Tailwinds "
      code:
        text "md:"
      text " variant, styles can easily be changed, based on the client screen's "
      code:
        text "min-width"
      text ". That took care of most responsiveness issues."
    p:
      text """
Additionally, for mobile, this website uses a special menu, which is turned on
and off based on """
      code:
        text "clientWidth"
      text ", as could be seen in the very first example."


