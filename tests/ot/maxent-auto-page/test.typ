#import "/lib.typ": *
// An auto-width page must grow to fit the probability bars, with no extra margin
#set page(width: auto, height: auto, margin: 0.5em)

#let tableau = maxent(
  input: "kraTa",
  candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
  constraints: ("Max", "Dep", "Complex"),
  weights: (2.5, 1.8, 1),
  violations: ((0, 0, 1), (1, 0, 0), (0, 1, 0)),
)

#tableau

#pagebreak()

// Same inside a container that sizes itself to its content
#grid(columns: 2, gutter: 1em, tableau, [Next cell])
