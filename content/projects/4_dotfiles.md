[creationTime]:- "Feb 13. 2023"
[lastWriteTime]:- "Feb 21. 2023"

# dotfiles

<a href="https://github.com/aMOPel/dotfiles">
<img src="assets/icons8-github.svg" alt="GitHub" class="inline m-1 dark:invert">
GitHub</a>

Dotfiles contains my configuration files for development tools.

The **term** "dotfiles" stems from the convention on Linux to
put configuration files in hidden folders or use hidden files,
which start with a `.`.

The **goal** of a dotfiles repository is to have one central place for all your
configuration files. This entails easy syncing between devices,
easy bootstrapping of new devices and of course all the benefits of version
control, like being able to rollback, when issues arise.

My dotfiles are currently built to work well on a Ubuntu-based Linux distributions,
but it could also be adapted to work on other Linux distros or Windows with WSL.

If deployed on an eligible system it can be set up in quite little time 
as most of the setup process is scripted.

The dotfile manager [Chezmoi](https://www.chezmoi.io/) takes care of 
applying the state of the dotfiles repository to the OS home `~/` folder.
The folder structure in the repository contains information about which files
to put where.
Additionally there are some scripts included to install dependencies.

Overall this comes pretty close to a perfect One-Command-Setup.

In the future I might also explore Nix for that.
Until now, I didn't need to migrate too often, so the need to perfect
the setup process, didn't arise yet.

The mentionable tools that are configured are 
- [NeoVim](https://neovim.io/) (terminal based text editor with similar extensibility to VSCode)
- [Ranger](https://ranger.github.io/) (terminal UI file explorer)
- [ZSH](https://zsh.sourceforge.io/) (shell, slightly fancier than bash)
- [Kitty](https://sw.kovidgoyal.net/kitty/) (modern terminal emulator)

The benefits of choosing such a terminal heavy set of tools are:
- A keyboard focused workflow, which entails
  - an ergonomic devoloper experience and
  - faster editing 
- Scriptability and automation of every task, like
  - macros in editing 
  - shell aliases and scripts for starting development environments
    and other repetitive tasks

## Examples

### Shell Alias For Development Environments

To develop this website I used a shell alias to start the development
environment. It opens 3 terminal windows starting the local http server and
file watchers. Also it opens my NeoVim session in a new tab.
Finally a new tab in my browser gets opened at the address of the http server.
That means I type `website`, everything starts automatically,
and I can continue where I left off.

![dev_env](assets/kitty_website_dev_env.png)

### Custom Editor Mappings For Repetitive tasks

I tried to simplify this example, but it is still a very specific use case,
so don't get lost in the details of the use case, but rather look at the bigger
picture of reducing friction, when doing repetitive tasks.

When developing my [tree-sitter-nim](https://github.com/aMOPel/tree-sitter-nim) project,
I had to write a lot of tests.

The test cases have a specific format:

```txt
==================
comment                             <- test case name
==================

# testing comments                  <- code that gets parsed
discard true # testing comments     <-
  # testing comments                <-

---

(module                             <- the expected AST (abstract syntax tree)
  (comment)                         <- after parsing the code
  (stmt                             |
    (discardStmt                    v
      (keyw)
      (expr
        (primary
          (literal
            (bool_lit))))))
  (comment)
  (comment))
```

The first step to make writing test cases easier, was to create a snippet to be used
in my editor, to quickly create the outline of the test case.
This means I type `t` followed by `tab` and get the following.

```
==================
$1
==================

$2

---

$3
```

The cursor will be at `$1`, there I can type in the name of the test case.
Typing `tab` again will take the cursor to `$2` and then to `$3`.

Next, regarding `$2`:
The code that gets parsed can't be handled nicely in the test file, since, when
working on the test case, the code needs to be executed sometimes to see if it compiles.
Additionally I don't get any syntax highlighting, linting and other editor benefits in
the test file, since it's the wrong filetype.
Thus I made a mapping to extract the code for my test case from a `.nim` file.
This means I execute the mapping at position `$2`,
and the code from a specific file gets inserted there.

Finally regarding position `$3`: the expected output of the parser, the 
AST (abstract syntax tree).
A crude approach would be to hand copy the output of the parser after it 
parsed as desired.
This doesn't scale very well, since bigger test cases produce ASTs
with over 100 lines. That means a lot of scrolling while copying.
Instead, when parsing the code, the result gets written to a specific file
and when using a mapping at `$3` the content of that file will be inserted there.

The final workflow looks somewhat like this:
1. I work on a test case in the `.nim` file.
2. I let the parser run on it and adapt it, until the AST is as I want it.
3. I go to the file containing the test cases and type `t` `tab`, followed by the test case name,
4. I type `tab`, followed by the mapping to insert the code,
5. And finally `tab` again followed by the mapping that inserts the AST.

Done. This means creating a test case takes seconds instead of minutes.

<!--TODO: macros-->
### Editor Macros for specific repetive tasks

**TODO**
