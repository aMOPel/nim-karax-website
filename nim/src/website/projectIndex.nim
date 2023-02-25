import pkg/karax/[vdom, karaxdsl, kbase, kdom, karax]
import globals, dates

proc resortProjects =
  let selO = getElementById("sortOptions").selectedOptions
  if selO.len == 1:
    selectedSortOption = selO[0].value.`$`
    sortSubContents("projects")
  else:
    echo "unexpected issue with select#sortOptions "

proc buildSortOptions*(): VNode =
  result = buildHtml():
    tdiv(class="""
      w-fit p-2
    """):
      label(`for`="sortOptions", class="px-2"):
        text "Sort By"
      select(id="sortOptions", class="""
        border-2 border-grey dark:border-dmgrey
        hover:border-red dark:hover:border-dmred
        bg-grey dark:bg-dmgrey
        hover:shadow-md hover:shadow-black

        focus:ring-0
        focus:border-red dark:focus:border-red
        active:border-red dark:active:border-red
        focus-visible:outline-none
      """,
      onchange=resortProjects):
        for k in sortOptions.keys:
          option(
            value=k.cstring,
            selected=(k == initialSortOption).`$`.cstring
          ):
            text k

proc buildProjectList(): VNode =
  result = buildHtml():
    nav:
      ul(class="""
        list-none m-0 p-0 
        divide-black dark:divide-dmblack divide-y divide-solid
      """):
        for name, c in contents["projects"]:
          li(class="m-0 p-0 py-2"):
            tdiv(class="""
              m-0 p-0
            """):
              a(href= kstring("#/" & name),
                class="""
                  no-underline dark:hover:text-dmblack hover:text-black
                """):
                tdiv(class="""
                  border-2 border-grey dark:border-dmgrey
                  hover:border-red dark:hover:border-dmred
                  hover:shadow-md hover:shadow-black
                  p-3 my-0 
                """):
                  let content = c.content()
                  content[0].class &= " mb-0 mt-1"
                  c.buildDates
                  content[0]
                  content[2]

proc buildProjectIndex*(): VNode =
  result = buildHtml():
    tdiv(class="""
      divide-black dark:divide-dmblack divide-y divide-solid
    """):
      buildSortOptions()
      buildProjectList()
