
include karax / prelude
import std/[strformat]
import globals

proc buildDates*(c: Content): VNode =
  result = buildHtml:
    tdiv(class="mb-2 "):
      p(class="[font-size:0.75rem] italic leading-none p-0 m-0 text-[#2524227a] dark:text-[#FFFCF27a]"):
        text &"Written: {c.creationTime}"
      p(class="[font-size:0.75rem] italic leading-none p-0 m-0 text-[#2524227a] dark:text-[#FFFCF27a]"):
        text &"Last updated: {c.lastWriteTime}"
