# This Website

<a href="https://github.com/aMOPel/nim-karax-website/tree/amopels_content">
<img src="assets/icons8-github.svg" alt="GitHub" class="inline m-1 ">
GitHub</a>

This very website 
is a Single Page Application using transpiled Markdown as a source of content.

It was build 
using [Nim](https://nim-lang.org/), [Karax](https://github.com/karaxnim/karax) and [TailwindCSS](https://tailwindcss.com/).

Among other things, Karax provides a DSL in Nim to describe HTML.
This allows for describing the HTML layout intermingled with the imperative code.
A concept somewhat similar to Vue's concepts of template syntax, conditional rendering etc.
Only in Vue it's about inserting functionality into HTML,
but in Karax it's about generating HTML using a programming language.

The Nim code can be compiled to a SPA JavaScript file, which renders the whole website.

On top of that, the Tailwind utility classes can be written directly into the
Karax HTML tags. Tailwind is not strictly necessary to apply style to the tags,
since the tags also have a mutable `style` attribute, however Tailwind makes the
application of the styles a little simpler.

The resulting project structure is quite interesting, as every aspect of the 
website can be described in Nim and manipulated using it.

The different parts of the website can be split up into reusable components 
(which are just functions in this case) and separated into modules,
also similar to Vue.

This structure however is completely orthogonal to the often advertised 
"separation of concerns". Instead of ordering Code by concerns 
(layout, style, functionality), it can be ordered by components, in which
the concerns are mixed and matched as needed.

Example:

*The menu component with collapsed Tailwind classes:*
```nim
proc buildMenu*(
  kxi: KaraxInstance,
  menu: openArray[tuple[text: string, href: string]]
): VNode =
  result = buildHtml(nav(class="...")):
    ul(class="..."):
      for (t, href) in menu:
        li(class="..."):
          a(class="...", href = &"#/{href}", onclick=kxi.onClickRedraw):
            text t
```
Since the Tailwind classes are just strings in Nim,
they can be composed in any way desired, using string manipulation.

The benefit over Vue would be that there is no necessity for a separate file
format like `.vue` and resulting tooling issues,
like completion, linting, formatting, highlighting etc.

A downside is of course, that Nim's ecosystem is inferior to JavaScript's,
in terms of libraries, documentation and support, due to the big difference in
user base size.

<hr/>

Also notable, apart from the architecture, is the content management.

Using my file watcher [nosey](#/nosey), Markdown files get transpiled to the 
Karax DSL. That Nim code can then be imported and integrated into the website
as desired. 

For example, this website is using the file names of the Markdown 
files as routes for which the content will be the content of the Markdown file.

<hr/>

From a design perspective relevant might be the support for Dark Mode/Light Mode and some basic responsiveness, as there is a 
special Mobile Menu (which you have to refresh the page for, if you're using the inspector on desktop).

The responsiveness of the content column is done with Tailwind's media queries,
the mobile menu is done via the DOM Interface in Nim. The switch happens
at a cutoff of 640px `clientWidth`.
