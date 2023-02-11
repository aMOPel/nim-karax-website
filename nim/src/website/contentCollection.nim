import karax/vdom

type Content* = object
  index*: int
  subDir*: string
  name*: string
  content*: proc(): VNode
  creationTime*: string
  lastWriteTime*: string

var contents*: seq[Content]

import content/godot_grid
contents.add Content(
  name: "godot_grid",
  content: godot_grid.createDom,
  creationTime: "07-02-2023 16:02",
  lastWriteTime: "06-02-2023 15:32"
)
import content/godot_exchange_scene
contents.add Content(
  name: "godot_exchange_scene",
  content: godot_exchange_scene.createDom,
  creationTime: "07-02-2023 16:02",
  lastWriteTime: "06-02-2023 15:32"
)
import content/dotfiles
contents.add Content(
  name: "dotfiles",
  content: dotfiles.createDom,
  creationTime: "07-02-2023 16:10",
  lastWriteTime: "06-02-2023 15:29"
)
import content/fixedpoint_nim
contents.add Content(
  name: "fixedpoint_nim",
  content: fixedpoint_nim.createDom,
  creationTime: "07-02-2023 16:02",
  lastWriteTime: "08-02-2023 16:48"
)
import content/home
contents.add Content(
  name: "home",
  content: home.createDom,
  creationTime: "07-02-2023 16:02",
  lastWriteTime: "08-02-2023 16:59"
)
import content/fomu_trng
contents.add Content(
  name: "fomu_trng",
  content: fomu_trng.createDom,
  creationTime: "07-02-2023 16:02",
  lastWriteTime: "06-02-2023 15:31"
)
import content/tasketeer_nim
contents.add Content(
  name: "tasketeer_nim",
  content: tasketeer_nim.createDom,
  creationTime: "07-02-2023 16:02",
  lastWriteTime: "06-02-2023 15:34"
)
import content/experience
contents.add Content(
  name: "experience",
  content: experience.createDom,
  creationTime: "07-02-2023 22:17",
  lastWriteTime: "09-02-2023 17:51"
)
import content/tree_sitter_nim
contents.add Content(
  name: "tree_sitter_nim",
  content: tree_sitter_nim.createDom,
  creationTime: "07-02-2023 16:02",
  lastWriteTime: "06-02-2023 15:34"
)
import content/nosey_nim
contents.add Content(
  name: "nosey_nim",
  content: nosey_nim.createDom,
  creationTime: "07-02-2023 22:37",
  lastWriteTime: "07-02-2023 22:58"
)
import content/this_website
contents.add Content(
  name: "this_website",
  content: this_website.createDom,
  creationTime: "07-02-2023 22:56",
  lastWriteTime: "10-02-2023 22:55"
)
import content/godot_tetris_clone
contents.add Content(
  name: "godot_tetris_clone",
  content: godot_tetris_clone.createDom,
  creationTime: "09-02-2023 19:46",
  lastWriteTime: "09-02-2023 23:42"
)
