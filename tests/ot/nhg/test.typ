#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

#nhg(
  input: "kraTa",
  candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
  constraints: ("Max", "Dep", "*Complex"),
  weights: (2.5, 1.8, 1),
  violations: ((0, 0, -1), (-1, 0, 0), (0, -1, 0)),
  seed: 7,
)
