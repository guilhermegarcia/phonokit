#import "/lib.typ": *
// Probability bars sit outside the table bounds: leave room for them
#set page(width: auto, height: auto, margin: (left: 0.5em, y: 0.5em, right: 6em))

#maxent(
  input: "kraTa",
  candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
  constraints: ("Max", "Dep", "Complex"),
  weights: (2.5, 1.8, 1),
  violations: ((0, 0, 1), (1, 0, 0), (0, 1, 0)),
  visualize: true,
)
