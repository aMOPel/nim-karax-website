import karax/vdom

type Content* = object
  index*: int
  subDir*: string
  name*: string
  content*: proc(): VNode
  creationTime*: string
  lastWriteTime*: string

var contents*: seq[Content]


import content/projects/tasketeer_nim as projects_tasketeer_nim
contents.add Content(
  index: 8,
  subDir: "projects",
  name: "tasketeer_nim",
  content: projects_tasketeer_nim.createDom,
  creationTime: "11-02-2023 17:42",
  lastWriteTime: "11-02-2023 22:02"
)
import content/special/experience as special_experience
contents.add Content(
  index: 0,
  subDir: "special",
  name: "experience",
  content: special_experience.createDom,
  creationTime: "11-02-2023 17:42",
  lastWriteTime: "11-02-2023 22:02"
)
import content/projects/godot_grid as projects_godot_grid
contents.add Content(
  index: 2,
  subDir: "projects",
  name: "godot_grid",
  content: projects_godot_grid.createDom,
  creationTime: "11-02-2023 17:42",
  lastWriteTime: "11-02-2023 22:02"
)
import content/special/home as special_home
contents.add Content(
  index: 0,
  subDir: "special",
  name: "home",
  content: special_home.createDom,
  creationTime: "11-02-2023 17:42",
  lastWriteTime: "11-02-2023 22:21"
)
import content/projects/godot_tetris_clone as projects_godot_tetris_clone
contents.add Content(
  index: 3,
  subDir: "projects",
  name: "godot_tetris_clone",
  content: projects_godot_tetris_clone.createDom,
  creationTime: "11-02-2023 17:42",
  lastWriteTime: "11-02-2023 22:04"
)
import content/projects/dotfiles as projects_dotfiles
contents.add Content(
  index: 4,
  subDir: "projects",
  name: "dotfiles",
  content: projects_dotfiles.createDom,
  creationTime: "11-02-2023 17:42",
  lastWriteTime: "11-02-2023 22:02"
)
import content/projects/fixedpoint_nim as projects_fixedpoint_nim
contents.add Content(
  index: 7,
  subDir: "projects",
  name: "fixedpoint_nim",
  content: projects_fixedpoint_nim.createDom,
  creationTime: "11-02-2023 17:42",
  lastWriteTime: "11-02-2023 22:02"
)
import content/projects/godot_exchange_scene as projects_godot_exchange_scene
contents.add Content(
  index: 1,
  subDir: "projects",
  name: "godot_exchange_scene",
  content: projects_godot_exchange_scene.createDom,
  creationTime: "11-02-2023 17:42",
  lastWriteTime: "11-02-2023 22:02"
)
import content/projects/this_website as projects_this_website
contents.add Content(
  index: 10,
  subDir: "projects",
  name: "this_website",
  content: projects_this_website.createDom,
  creationTime: "11-02-2023 17:42",
  lastWriteTime: "11-02-2023 22:02"
)
import content/projects/tree_sitter_nim as projects_tree_sitter_nim
contents.add Content(
  index: 6,
  subDir: "projects",
  name: "tree_sitter_nim",
  content: projects_tree_sitter_nim.createDom,
  creationTime: "11-02-2023 17:42",
  lastWriteTime: "11-02-2023 22:02"
)
import content/projects/nosey_nim as projects_nosey_nim
contents.add Content(
  index: 9,
  subDir: "projects",
  name: "nosey_nim",
  content: projects_nosey_nim.createDom,
  creationTime: "11-02-2023 17:42",
  lastWriteTime: "11-02-2023 22:02"
)
import content/projects/fomu_trng as projects_fomu_trng
contents.add Content(
  index: 5,
  subDir: "projects",
  name: "fomu_trng",
  content: projects_fomu_trng.createDom,
  creationTime: "11-02-2023 17:42",
  lastWriteTime: "11-02-2023 22:02"
)
