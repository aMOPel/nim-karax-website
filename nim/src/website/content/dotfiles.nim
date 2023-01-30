include karax / prelude

proc createDom*(): VNode =
  result = buildHtml(tdiv):
    p(id="timestamp"): text "last updated 30-01-2023 22:44"
    h1:
      a(href = "https://github.com/aMOPel/dotfiles"):
        text "dotfiles"
    p:
      text """
Dotfiles contains my configuration files for the development tools. It is
currently built to work well on a ubuntu based linux distro, but it could also
be adapted to work on other linux distros or windows with WSL."""
    p:
      text """
The term dotfiles stems from the convention on linux to put configuration files
in hidden folders, which start with a """
      code:
        text "."
      text "."
    p:
      text """
If deployed on an eligible system it can be set up in quite little time as most
of the setup process is scripted."""
    p:
      text "The mentionable tools that are configured are"
    ul:
      li:
        text "neovim (terminal based text editor with similar extensibility to VSCode)"
      li:
        text "ranger (terminal UI file explorer)"
      li:
        text "zsh (shell, slightly fancier than bash)"
      li:
        text "kitty (modern terminal emulator)"
    p:
      text "The benefits of choosing such a terminal heavy set of tools are:"
    ul:
      li:
        text "keyboard focused workflow, ergonomic, fast"
      li:
        text "scriptability/automation of every task"


