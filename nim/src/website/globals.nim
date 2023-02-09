include karax / prelude
import std/[algorithm, sugar, times]
import karax/kdom
import contentCollection

export contentCollection.Content

type
  MenuItem* = tuple[text: string, href: string]
const
  dateFormat* = "dd-MM-yyyy HH:mm"
  mobileMenuWidthThreshold* = 500
var
  homeContent*: Content
  experienceContent*: Content
  articleContents* = contentCollection.contents

# filtering the home/experience content out
var toBeDeleted: seq[int]
for i, c in articleContents.pairs:
  if c.name == "home":
    homeContent = c
    toBeDeleted.add i
  elif c.name == "experience":
    experienceContent = c
    toBeDeleted.add i
# need to sort bigger indeces up, so they get deleted first 
# and don't change the other indeces
toBeDeleted.sort(Descending)
for i in toBeDeleted:
  articleContents.delete i

# sort by article creationTime
articleContents.sort((x,y:Content) =>
  cmp(x.creationTime.parse(dateFormat), y.creationTime.parse(dateFormat)),
  order=Descending)

# to redraw the page after a link was clicked
proc onClickRedraw*(site: KaraxInstance): proc =
  result = proc = 
    site.redrawSync
    window.scrollTo(0,0)

