import pkg/karax/[vdom, karaxdsl, karax, kbase]
import std/[sequtils]
import globals

var
  menuContent = tdiv.tree
  menuImage = "assets/icons8-menu.svg".kstring
  cancelImage = "assets/icons8-close.svg".kstring
  buttonImage = menuImage

  menu: seq[MenuItem]

proc toggleMenu()

proc buildMobileMenuContent(): VNode =
  result = buildHtml(nav(class="""
      fixed top-0 left-0
      h-screen w-screen
      z-40
      bg-grey dark:bg-dmgrey 
    """)):
      ul(class="""
          mt-20
          text-2xl text-black dark:text-dmblack font-bold
          divide-black dark:divide-dmblack divide-y divide-solid
          text-center
        """):
        for (t, href) in menu:
          li(class="""
            m-0 p-5
            w-screen
          """):
            a(class="""
            """, href = kstring("#/" & href), onclick=toggleMenu):
              tdiv(class="""
                w-full
                border-2 border-grey dark:border-dmgrey
                hover:border-red dark:hover:border-dmred
                hover:shadow-md hover:shadow-black
                p-3
              """):
                p:
                  text t

proc toggleMenu() =
  if buttonImage == cancelImage:
    buttonImage = menuImage
    menuContent = tdiv.tree
  else:
    buttonImage = cancelImage
    menuContent = buildMobileMenuContent()

proc buildMobileMenu*(
  menu: openArray[MenuItem]
  ): VNode =
  mobileMenu.menu = menu.toSeq

  result = buildHtml(tdiv(class="""
    w-screen
  """)):
    menuContent
    button(class="""
      z-50
      fixed top-3 right-3
      p-2
      hover:bg-grey dark:hover:bg-dmgrey
      hover:border-2 hover:border-red dark:hover:border-dmred
      hover:shadow-md hover:shadow-black
    """, onclick=toggleMenu):
      img(src=buttonImage, class="w-10 h-10 dark:invert")
