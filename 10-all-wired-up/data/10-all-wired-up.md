# [[#10] All Wired Up](http://www.puzzlenode.com/puzzles/10-all-wired-up)

_This puzzle was contributed by Gregory Brown &amp; Andrea Singh and published on July 14, 2011_

Your task in this brain teaser is to traverse various electrical circuits and determine whether the light bulb at the end of a tangled mess of wires will be on or off.

## Elements of the Wiring System 

There are two main aspects to the electrical system. First, there are switches which can be either on or off, thereby allowing the current to flow through or else to be interrupted. In addition, there are "gates" which combine and process the signals coming from two wires. 

Essentially, these gates can be thought of as Boolean operators. As such, they combine true and false states of their input signals, yielding an output in accordance with their internal logic.

In this puzzle, the possible types of gate operators are restricted to just the following four:

**AND Gate**: says that if _all_ inputs are on, then the output will also be on. See this table to reference the logical possibilities:

```
+--------------------------+
|  AND Gate                |
+--------+--------+--------+
| Input1 | Input2 | Output |
| 1      | 1      | 1      |
| 1      | 0      | 0      |
| 0      | 1      | 0      |
| 0      | 0      | 0      |
+--------+--------+--------+
```

**OR Gate**: says that if _any_ input is on, then the output will also be on.

```
+--------------------------+
|  OR Gate                 |
+--------+--------+--------+
| Input1 | Input2 | Output |
| 1      | 1      | 1      |
| 1      | 0      | 1      |
| 0      | 1      | 1      |
| 0      | 0      | 0      |
+--------+--------+--------+
```

**XOR Gate**: the exclusive OR gate says that the output will be on if the inputs are _different_.

```
+--------------------------+
|  XOR Gate                |
+--------+--------+--------+
| Input1 | Input2 | Output |
| 1      | 1      | 0      |
| 1      | 0      | 1      |
| 0      | 1      | 1      |
| 0      | 0      | 0      |
+--------+--------+--------+
```

**NOT Gate**: this is also called an "inverter" and only processes the input from _one_ single wire. It simply changes the input to its opposite.

```
+-------------------+
| Not Gate          |
+----------+--------+
| Input    | Output |
| 1        | 0      |
| 0        | 1      |
+----------+--------+
```

## The ASCII Representation of the Wiring System 

### Input Files and Symbols

The input files will contain multiple circuits separated by empty lines. Every circuit ends with a light bulb, symbolized by an `@` symbol.

This simple example illustrates the various elements that can be encountered in the input file.

```
0-------------|
              |
              O-----------@
1-------------|
```

Here you can see two switches, one off (represented by `0`) and one on (represented by `1`), that are combined by an "OR" gate (pictured by a capital `O`). In this simple scenario, combining the true and false values by "OR" will result in "true" and thus the light bulb at the end will be "on".

Here's a glossary of all the elements:

- **@**: the light bulb. Can be either on or off and is the endpoint of the wiring system. The output file needs to list the state of all light bulbs that can be found in the input file as "on" or "off".
- **0** and **1**: the switches that are either on or off. Simply put, these are the true/false values that will be combined by the logic gates.
- **-** and **|**: the conduit wires. The horizontal wires are represented by dashes. The vertically running wires always meet at a logic gate.
- **A**, **O**, **X** and **N**: logic gates standing for "AND", "OR", "XOR" and "NOT", respectively.

Let's walk through a slightly more complex example:

```
0-------------|
              A------------|
1-------------|            |
                           X------------@
1-------------|            |
              N------------|
```

The current is flowing from left to right, so starting with the `A` gate we can see that it will evaluate to false. The `N` gate will also evaluate to false. Note here the special case of `N` gates. Being unary operators, they only process the input signal from a single wire.

Next, the `X` gate combines the output from the `A` and the `N` gates and as such will evaluate to false. So for this circuit, the lightbulb is off.

Note that to optimally view the wiring system in the input file be sure to adjust your text editor to not wrap lines.

### Output File Format

For each circuit in the input file, you need to print the state of the light bulb as `on` or `off` on separate lines. For example:

```
on
on
off
....
```

You can test out your code with the `simple_circuits.txt` input file. The correct output for this sample can be found in `simple_output.txt`. 

The input file you need to use to solve this puzzle is `complex_circuits.txt`.