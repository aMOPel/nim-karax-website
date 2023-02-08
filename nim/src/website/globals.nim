include karax / prelude
import std/[algorithm, sugar, times]
import contentCollection

export contentCollection.Content

const dateFormat = "dd-MM-yyyy HH:mm"
var
  homeContent*: Content
  experienceContent*: Content
  articleContents* = contentCollection.contents

# filtering the home content out
var toBeDeleted: seq[int]
for i, c in articleContents.pairs:
  if c.name == "home":
    homeContent = c
    toBeDeleted.add i
  elif c.name == "experience":
    experienceContent = c
    toBeDeleted.add i
for i in toBeDeleted:
  articleContents.delete i

# sort by article creationTime
articleContents.sort((x,y:Content) =>
  cmp(x.creationTime.parse(dateFormat), y.creationTime.parse(dateFormat)),
  order=Descending)

# to redraw the page after a link was clicked
proc onClickRedraw*(site: KaraxInstance): proc =
  result = proc = site.redrawSync

