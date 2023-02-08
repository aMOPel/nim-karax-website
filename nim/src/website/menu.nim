include karax / prelude
import std/[strformat]
import globals

# TODO: remove double link from buttons
proc buildMenu*(
  kxi: KaraxInstance,
  menu: openArray[tuple[text: string, href: string]]
): VNode =
  result = buildHtml(nav(class="""
    bg-grey dark:bg-dmgrey 
    border-x-darkgrey dark:border-x-dmdarkgrey border-x-4
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
          inline
          m-0 p-0 px-2
        """):
          a(class="""
            p-2
            border-2 border-grey dark:border-dmgrey
            hover:border-red dark:hover:border-dmred
            hover:shadow-black hover:shadow-md
          """, href = &"#/{href}", onclick=kxi.onClickRedraw):
            text t
