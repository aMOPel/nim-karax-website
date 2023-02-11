include karax / prelude

proc createDom*(): VNode =
  result = buildHtml(article):
    h1:
      text "fomu-trng"
    a(href = "https://github.com/aMOPel/fomu-trng"):
      img(src = "icons8-github.svg", class = "inline m-1", alt = "GitHub")
      text "GitHub"
    p:
      text "This project is the result of my bachelor thesis."
    p:
      text "It is about connecting a "
      a(href = "https://en.wikipedia.org/wiki/Hardware_random_number_generator"):
        text "TRNG"
      text """
 (true random number generator) via USB to a PC and making the random data
available in software. The TRNG was put on an """
      a(href = "https://en.wikipedia.org/wiki/Field-programmable_gate_array"):
        text "FPGA"
      text " Device, namely the "
      a(href = "https://tomu.im/fomu.html"):
        text "Fomu"
      text "."
    p:
      text "The focus of the thesis was to "
      strong:
        text "choose"
      text " and "
      strong:
        text "integrate"
      text " various technologies to achieve the goal, as well as "
      strong:
        text "evaluate"
      text " the resulting random data."
    p:
      text """
That means the code I had to write on a hardware level was only about glueing
the interfaces of the technologies together. This was still quite involved for
me, since I never worked with hardware technologies like this before."""
    p:
      text """
I also had to write a pipeline to collect data, as well as visualizing the
resulting data, which I did using """
      a(href = "https://nim-lang.org/"):
        text "Nim"
      text "."


