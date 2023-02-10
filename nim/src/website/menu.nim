include karax / prelude
import std/[strformat]
import karax/kdom
import globals
import mobileMenu



proc buildMenu*(
  kxi: KaraxInstance,
  menu: openArray[MenuItem]
): VNode =
  if clientWidth() < mobileMenuWidthThreshold:
    result = buildMobileMenu(kxi, menu)
  else:
    result = buildHtml(nav(class="""
      bg-grey dark:bg-dmgrey 
      md:border-x-darkgrey md:dark:border-x-dmdarkgrey md:border-x-4
      max-w-3xl w-full 
      mx-auto sticky top-0 p-3 
      drop-shadow-lg
    """)):
        ul(class="""
          bg-grey dark:bg-dmgrey
          text-lg text-black dark:text-dmblack font-bold
          divide-black dark:divide-dmblack divide-x divide-solid
        """):
          for (t, href) in menu:
            li(class="""
              m-0 p-0 px-2
              inline-block
            """):
              a(class="""
                p-2
                hover:border-2 hover:border-red dark:hover:border-dmred
                hover:shadow-black hover:shadow-md
              """, href = &"#/{href}", onclick=kxi.onClickRedraw):
                text t
