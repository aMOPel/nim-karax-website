[creationTime]:- "Feb 13. 2023"
[lastWriteTime]:- "Feb 21. 2023"

# fomu-trng

<a href="https://github.com/aMOPel/fomu-trng">
<img src="assets/icons8-github.svg" alt="GitHub" class="inline m-1 dark:invert">
GitHub</a>

This project is the result of my bachelor thesis.

It is about connecting 
a [TRNG](https://en.wikipedia.org/wiki/Hardware_random_number_generator) (true random number generator)
via USB to a PC and making the random data available in software.
The TRNG was put on an [FPGA](https://en.wikipedia.org/wiki/Field-programmable_gate_array) Device,
namely the [Fomu](https://tomu.im/fomu.html).

![fomu](assets/ba_fomu.png)

The focus of the thesis was to **choose** and **integrate** various technologies to achieve the goal,
as well as **evaluate** the resulting random data.
Another aspect of the thesis was to make the code open source and document
the installation and usage properly.

The code I had to write on a hardware level was
just about glueing the interfaces of the technologies together.
This was still quite involved for me, since I never worked with hardware technologies like this before.

In the end I ended up with a structure looking like this:

![data_flow](assets/ba_data_flow.png)

MuACM was the module I used to send data over USB, and the NeoTRNG module was generating the
random numbers.
I glued their interfaces together with the FSM (finite state machine),
which also handled the user input and thus the control flow.

![fsm](assets/ba_fsm_full.png)

I also had to write a pipeline to collect data,
as well as visualizing the resulting data,
which I did using [Nim](https://nim-lang.org/).
This part probably took at least as much time as the hardware part.

Here an example chart, generated using [plotly](https://plotly.com/) bindings in Nim.
![chart](assets/ba_9_norm_post.png)
