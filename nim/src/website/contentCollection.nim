import karax/vdom

type Content* = object
  index*: int
  subDir*: string
  name*: string
  content*: proc(): VNode
  creationTime*: string
  lastWriteTime*: string

var contents*: seq[Content]

include contentImports
