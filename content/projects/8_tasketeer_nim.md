[creationTime]:- "Feb 13. 2023"
[lastWriteTime]:- "Feb 21. 2023"

# tasketeer.nim

<a href="https://github.com/aMOPel/tasketeer.nim/tree/try_dynlib_backend">
<img src="assets/icons8-github.svg" alt="GitHub" class="inline m-1 dark:invert">
GitHub</a>

Tasketeer is a prototype of a To-Do App made with [Nim](https://nim-lang.org/).

The goal of this project was mainly to play around with architecture.
I settled on the following:

The data is saved through a **dynamic library** interface. 
I only implemented a SQLite backend using an ORM library,
however it is possible to write another dynamic library that plugs into the same
interface, which uses another storage solution.

```nim
# The backend needs to implement these procs
proc add*(t: Task): R {.cdecl, importc, dynlib: dllName().}
proc delete*(t: Task): R {.cdecl, importc, dynlib: dllName().}
proc update*(task: Task, updatedTask: UpdatedTask): R
  {.cdecl, importc, dynlib: dllName().}
proc query*(filter: Filter): R {.cdecl, importc, dynlib: dllName().}
proc init*(config: Config): R {.cdecl, importc, dynlib: dllName().}
```

The frontend was also constructed in a way to support multiple frontend solutions, like web.
I only implemented a CLI, though. 
Also the frontend was basically split into input (command line) and output (print to stdout).

Another part of the architecture was, that it is possible to choose the backend 
dynamic library in a configuration file.

Apart from architecture, this project turned out to be an exercise
in **error handling**,
as faults in the user input and backend had to be handled properly.

I experimented with using a special `Result` type 
(in the above snipped called `R`), which either holds the resulting data, or an
error message. This allows for an exception free method of error handling.
