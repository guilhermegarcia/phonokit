#import "lib.typ": *
#import "@preview/eggs:0.5.1": *

#show: eggs.with()

= Example

// Basic example from the manual
You're a were#int("*L")wol#int("H%", line: true)f?

// #v(2em)
//
// Boundary tone with line

A we#int("H*+L")rewolf?#int("L-H%", line: false)

// en-dash rendering
A we#int("H*+L")rewolf?#int("L-H%", line: false)
//
// #v(2em)
//
// // Downstepped tone

He #int("!H*")said no#int("L-L%")

//
// #v(2em)
//
// // Multiple pitch accents, no lines on boundary tones

Did #int("H*")you se#int("L+H*")e that#int("L-H%", line: false)
//
// #v(2em)
//
// // Custom height and lift
The rain#int("*L") in Spain#int("H%", line: false)
//
// #v(2em)
//
// // All labels with stems
// A#int("H*") B#int("L*") C#int("L+H*") D#int("!H*") E#int("L-L%")

= Numbered examples

This is using the `eggs` package for a numbered example. See @gl1 and @gl3.

#example[
  An example:
  + You're a were#int("L+H*")wolf?#int("L-L%", line: false)#ex-label(<gl1>)
  + You're a were#int("L+H*")wolf?#int("L-L%", line: false)#ex-label(<gl2>)
  + You're a were#int("L+H*")wolf?#int("L-L%", line: false)#ex-label(<gl3>)
]
