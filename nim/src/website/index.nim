include karax / prelude
import std/[strformat]
import globals, dates

proc buildIndex*(kxi: KaraxInstance): VNode =
  result = buildHtml(nav):
    ul(class="""
         list-none m-0 p-0 
         divide-black dark:divide-dmblack divide-y divide-solid
       """):
      for c in articleContents:
        li(class="m-0 p-0 py-2"):
          tdiv(class="""
            m-0 p-0
          """):
            a(href= &"#/{c.name}", onclick=kxi.onClickRedraw,
              class="""
                no-underline dark:hover:text-dmblack hover:text-black
              """):
              tdiv(class="""
                hover:border-2 hover:border-red dark:hover:border-dmred
                hover:shadow-md hover:shadow-black
                p-3 my-0 
              """):
                let content = c.content()
                content[0].class &= " mb-0 mt-1"
                c.buildDates
                content[0]
                content[2]
