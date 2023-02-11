include karax / prelude

proc createDom*(): VNode =
  result = buildHtml(article):
    h1:
      text "nosey.nim"
    a(href = "https://github.com/aMOPel/nosey.nim"):
      img(src = "icons8-github.svg", class = "inline m-1", alt = "GitHub")
      text "GitHub"
    p:
      text """
A minimal file watcher library, specialized on applying a state to a directory
based on another directory."""
    p:
      text """
This project came to be, because I needed a file watcher for this website, to
translate markdown files into an HTML DSL in """
      a(href = "https://nim-lang.org/"):
        text "Nim"
      text "."
    p:
      text """
It uses hashes of file contents to determine changes. This is far less efficient
and less versatile, compared to an OS-event-based approach, like """
      a(href = "https://github.com/paul-nameless/nim-fswatch"):
        text "libfswatch"
      text ", but this library is free of dependencies outside the Nim standard library."
    p:
      text """
The abstraction is really simple. A state object is created for a source
directory, by walking over the directory and creating hashes for all the file
contents."""
    pre:
      code(class = "language-nim"):
        text """type
  DirState* = object
    dirName*: string
    dirHash*: Hash
    fileHashes*: Table[string, Hash]
"""
    p:
      text "Later the "
      code:
        text "DirState"
      text """
 can be updated. Using sets of file names, this results in getting information
about new, changed and deleted files."""
    pre:
      code(class = "language-nim"):
        text """proc updateDirState*(s: var DirState): NewChangedDeleted
"""
    p:
      text """
The newfound changes can be applied to a target directory. This library itself
doesn't make any assumptions about how to mutate the target directory. Instead
the user gets to pass in callbacks """
      code:
        text "fileConverter"
      text " and "
      code:
        text "fileRemover"
      text """
, which are called for every changed and deleted file. That means the user can
mutate file contents, file names, or do something else entirely in the
callbacks."""
    pre:
      code(class = "language-nim"):
        text """proc applyDirState*(
  sourceState: DirState,
  targetDir: string,
  diffSets = NewChangedDeleted(),
  fileConverter: proc (sourceFilePath, targetDir: string)
    = defaultFileConverter,
  fileRemover: proc (sourceFilePath, targetDir: string)
    = defaultFileRemover,
)
"""
    p:
      text """
Finally that workflow is put into a while loop, to continuously update and apply
the state. Additionally """
      code:
        text "sourceStateJson"
      text " provides a mechanism to persist the directory state across sessions."
    pre:
      code(class = "language-nim"):
        text """proc watch*(
  sourceDir, targetDir: string,
  interval = 5000,
  fileConverter: proc (sourceFilePath, targetDir: string)
  = defaultFileConverter,
  fileRemover: proc (sourceFilePath, targetDir: string)
  = defaultFileRemover,
  sourceStateJson = ""
) =
"""


