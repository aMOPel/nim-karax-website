import std/[algorithm, sugar, tables, times, strutils, sequtils]
import contentCollection

export contentCollection.Content
export tables

type
  ContentsBySub* = Table[string, OrderedTable[string, Content]]
const
  dateFormat* = "MMM dd'.' yyyy"
  mobileMenuWidthThreshold* = 640
  initialSortOption* = "Chronological Order"
var
  contents*: ContentsBySub
  sortedContents = contentCollection.contents
  currentRoute*: string

proc snakeCaseToTitleCase*(s: string): string =
  s.split("_").map(capitalizeAscii).join(" ")

proc sortByIndex*(cs: var OrderedTable[string, Content], order=Descending) =
  cs.sort(
    (x,y:(string, Content)) => cmp(x[1].index, y[1].index),
    order=order)

proc sortByLastWriteTime*(cs: var OrderedTable[string, Content], order=Descending) =
  cs.sort(
    (x,y:(string, Content)) => (
      try:
        cmp(x[1].lastWriteTime.parse(dateFormat), y[1].lastWriteTime.parse(dateFormat))
      except TimeParseError:
        -1
      ),
    order=order)

let sortOptions* = {
  "Last Updated": sortByLastWriteTime,
  "Chronological Order": sortByIndex,
}.toTable
var selectedSortOption* = initialSortOption

proc separateIntoSubDirs(cs: seq[Content]): ContentsBySub =
  for c in cs:
    if result.hasKey c.subDir:
      result[c.subDir][c.name] = c
    else:
      result[c.subDir] = {c.name: c}.toOrderedTable

proc sortSubContents*(subKey: string) =
  sortOptions[selectedSortOption](contents[subKey])

contents = sortedContents.separateIntoSubDirs
for k in contents.keys:
  k.sortSubContents
