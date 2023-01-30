# [fomu-trng](https://github.com/aMOPel/fomu-trng)

This project is the result of my bachelor thesis.
It is about connecting a [TRNG](https://en.wikipedia.org/wiki/Hardware_random_number_generator) 
(true random number generator) via USB to a PC and making the random data available in software.
The TRNG was put on an [FPGA](https://en.wikipedia.org/wiki/Field-programmable_gate_array)
Device, namely the [Fomu](https://tomu.im/fomu.html).

The focus of the thesis was to **choose** and **integrate** various technologies to achieve the goal,
as well as **evaluate** the resulting random data.

That means the code I had to write on a hardware level was
only about glueing the intefaces of the technologies together.
This was still quite involved for me, since I never worked with hardware technologies like this before.

I also had to write a pipeline to collect data,
as well as visualizing the resulting data, which I did using [Nim](https://nim-lang.org/).
