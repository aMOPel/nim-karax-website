import karax/vdom

type Content* = object
  name*: string
  content*: proc(): VNode
  creationTime*: string
  lastWriteTime*: string

var contents*: seq[Content]

import content/test
contents.add Content(
  name: "test",
  content: test.createDom,
  creationTime: "08-02-2023 17:24",
  lastWriteTime: "08-02-2023 17:24"
)
import content/second
contents.add Content(
  name: "second",
  content: second.createDom,
  creationTime: "08-02-2023 17:24",
  lastWriteTime: "08-02-2023 17:24"
)
