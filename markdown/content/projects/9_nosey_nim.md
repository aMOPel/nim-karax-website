# nosey.nim

<a href="https://github.com/aMOPel/nosey.nim">
<img src="assets/icons8-github.svg" alt="GitHub" class="inline m-1 dark:invert">
GitHub</a>

A minimal file watcher library,
specialized on applying a state to a directory based on another directory.

This project came to be, because I needed a file watcher for this website,
to translate markdown files into an HTML DSL in [Nim](https://nim-lang.org/).

It uses hashes of file contents to determine changes.
This is far less efficient and less versatile,
compared to an OS-event-based approach, like [libfswatch](https://github.com/paul-nameless/nim-fswatch),
but this library is free of dependencies outside the Nim standard library.

The abstraction is really simple.
A state object is created for a source directory,
by walking over the directory and creating hashes for all the file contents.

```nim
type 
  DirState* = object
    dirName*: string
    dirHash*: Hash
    fileHashes*: Table[string, Hash]
```

Later the `DirState` can be updated. Using sets of file names,
this results in getting information about new, changed and deleted files. 

```nim
proc updateDirState*(s: var DirState): NewChangedDeleted
```

The newfound changes can be applied to a target directory.
This library itself doesn't make any assumptions
about how to mutate the target directory. Instead the user gets to pass in 
callbacks `fileConverter` and `fileRemover`, which are called for every changed
and deleted file. That means the user can mutate file contents, file names, or
do something else entirely in the callbacks.

```nim
proc applyDirState*(
  sourceState: DirState,
  targetDir: string,
  diffSets = NewChangedDeleted(),
  fileConverter: proc (sourceFilePath, targetDir: string)
    = defaultFileConverter,
  fileRemover: proc (sourceFilePath, targetDir: string)
    = defaultFileRemover,
)
```

Finally that workflow is put into a while loop, to continuously update and apply
the state. Additionally `sourceStateJson` provides a mechanism to persist the directory state
across sessions.

```nim
proc watch*(
  sourceDir, targetDir: string,
  interval = 5000,
  fileConverter: proc (sourceFilePath, targetDir: string)
  = defaultFileConverter,
  fileRemover: proc (sourceFilePath, targetDir: string)
  = defaultFileRemover,
  sourceStateJson = ""
) =
```
