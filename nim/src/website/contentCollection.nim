import karax/vdom

type Content* = object
  name*: string
  content*: proc(): VNode
  creationTime*: string
  lastWriteTime*: string

var contents*: seq[Content]

import content/home
contents.add Content(name: "home", content: home.createDom)
import content/tasketeer_nim
contents.add Content(name: "tasketeer_nim", content: tasketeer_nim.createDom)
import content/godot_grid
contents.add Content(name: "godot_grid", content: godot_grid.createDom)
import content/dotfiles
contents.add Content(name: "dotfiles", content: dotfiles.createDom)
import content/fixedpoint_nim
contents.add Content(name: "fixedpoint_nim", content: fixedpoint_nim.createDom)
import content/godot_exchange_scene
contents.add Content(name: "godot_exchange_scene", content: godot_exchange_scene.createDom)
import content/experience
contents.add Content(name: "experience", content: experience.createDom)
import content/fomu_trng
contents.add Content(name: "fomu_trng", content: fomu_trng.createDom)
import content/tree_sitter_nim
contents.add Content(name: "tree_sitter_nim", content: tree_sitter_nim.createDom)
