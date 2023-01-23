import karax/vdom

type Content* = object
  name*: string
  content*: proc(): VNode

var contents*: seq[Content]

import content/test
contents.add Content(name: "test", content: test.createDom)
import content/second
contents.add Content(name: "second", content: second.createDom)
