import std/[algorithm, sugar, tables]
# import std/[algorithm, sugar, times, tables]
import contentCollection

export contentCollection.Content
export tables

type
  MenuItem* = tuple[text: string, href: string]
  ContentsBySub* = Table[string, OrderedTable[string, Content]]
const
  dateFormat* = "dd-MM-yyyy HH:mm"
  mobileMenuWidthThreshold* = 640
var
  contents*: ContentsBySub
  sortedContents = contentCollection.contents


proc sortByIndex(cs: var seq[Content], order=Descending) =
  cs.sort(
    (x,y:Content) => cmp(x.index, y.index),
    order=order)

# proc sortByCreationTime(cs: var seq[Content], order=Descending) =
#   cs.sort(
#     (x,y:Content) => 
#       cmp(x.creationTime.parse(dateFormat), y.creationTime.parse(dateFormat)),
#     order=order)

proc separateIntoSubDirs(cs: seq[Content]): ContentsBySub =
  for c in cs:
    if result.hasKey c.subDir:
      result[c.subDir][c.name] = c
    else:
      result[c.subDir] = {c.name:  c}.toOrderedTable

sortedContents.sortByIndex
contents = sortedContents.separateIntoSubDirs
