[creationTime]:- "Feb 13. 2023"
[lastWriteTime]:- "Feb 16. 2023"

# fixedpoint.nim

<a href="https://github.com/aMOPel/fixedpoint.nim">
<img src="assets/icons8-github.svg" alt="GitHub" class="inline m-1 dark:invert">
GitHub</a>

This project was an exercise with the goal of creating 
a [fixed-point](https://en.wikipedia.org/wiki/Fixed-point_arithmetic) data type.

It is implemented in [Nim](https://nim-lang.org/).

This Nim library however doesn't work on a bit-level and
is thus not based on the binary number system but on the decimal number system.
This means it isn't as fast however it is quite easy to use (and to implement).

The only real use case for this library would be if you work with numbers that 
only have a limited amount of decimal places, like money.

In such cases the following problem can arise:
```nim
let 
  a = 0.566
  b = 0.466
  c = a + b
echo &"{a.round(2)} + {b.round(2)} = {c.round(2)}"

# prints: "0.57 + 0.47 = 1.03"
# but it doesn't add up!

# instead you would need to round your floats 
# everywhere before you operate on them
# (in fact that is more or less what this lib is doing)
```
This problem could be circumvented with this library.

Using Nim's flexibel operator overloading system,
I created a `$$` operator to construct fixed-point numbers.

```
# The `$` converts the number to a string
assert `$`($$3) == "0.000"
assert `$`(1000$$2) == "10.00"
```

The current implementation includes, among other things, support for all
common operators and comparators as well as conversion to/from 
`int`, `float` and `string`.
