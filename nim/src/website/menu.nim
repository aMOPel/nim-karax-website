import std/[sequtils]
import pkg/karax/[vdom, karaxdsl, kdom, kbase]
import globals
import mobileMenu

proc buildMenu*(menu: openArray[string]): VNode =
  if clientWidth() < mobileMenuWidthThreshold:
    result = buildMobileMenu(menu)
  else:
    result = buildHtml(nav(class="""
      bg-grey dark:bg-dmgrey 
      md:border-x-darkgrey md:dark:border-x-dmdarkgrey md:border-x-4
      max-w-3xl w-full 
      mx-auto sticky top-0 p-3 
      drop-shadow-lg
      z-50
    """)):
      ul(class="""
        bg-grey dark:bg-dmgrey
        text-lg text-black dark:text-dmblack font-bold
        divide-black dark:divide-dmblack divide-x divide-solid
      """):
        for href in menu:
          let menuItem = href.snakeCaseToTitleCase
          li(class="""
            m-0 p-0 px-2
            inline-block
          """):
            if currentRoute == href or 
              (href == "open_source_projects" and 
               currentRoute in contents["projects"].keys.toSeq):
              a(class="""
                p-2
                border-2 border-red dark:border-dmred
                hover:shadow-black hover:shadow-md
              """, href=kstring("#/" & href)):
                text menuItem
            else:
              a(class="""
                p-2
                border-2 border-grey dark:border-dmgrey
                hover:border-red dark:hover:border-dmred
                hover:shadow-black hover:shadow-md
              """, href=kstring("#/" & href)):
                text menuItem
