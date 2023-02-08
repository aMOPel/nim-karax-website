include karax / prelude

proc createDom*(): VNode =
  result = buildHtml(article):
    h1:
      text "dotfiles"
    a(href = "https://github.com/aMOPel/dotfiles"):
      img(src = "icons8-github.svg", class = "inline m-1", alt = "GitHub")
      text "GitHub"
    p:
      text "Dotfiles contains my configuration files for the development tools."
    p:
      text """
It is currently built to work well on a ubuntu based Linux distro, but it could
also be adapted to work on other Linux distros or windows with WSL."""
    p:
      text """
The term "dotfiles" stems from the convention on Linux to put configuration
files in hidden folders, which start with a """
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
        text "NeoVim (terminal based text editor with similar extensibility to VSCode)"
      li:
        text "Ranger (terminal UI file explorer)"
      li:
        text "ZSH (shell, slightly fancier than bash)"
      li:
        text "Kitty (modern terminal emulator)"
    p:
      text "The benefits of choosing such a terminal heavy set of tools are:"
    ul:
      li:
        text "keyboard focused workflow, ergonomic, fast"
      li:
        text "scriptability/automation of every task"


