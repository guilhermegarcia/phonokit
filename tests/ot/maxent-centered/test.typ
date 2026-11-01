#import "/lib.typ": *
// On a fixed-width page the bars must float: the table itself stays centered,
// and the caption's midpoint lines up with it
#set page(width: 16cm, height: auto, margin: 0.5em)

#figure(
  maxent(
    input: "kraTa",
    candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
    constraints: ("Max", "Dep", "Complex"),
    weights: (2.5, 1.8, 1),
    violations: ((0, 0, 1), (1, 0, 0), (0, 1, 0)),
  ),
  caption: [Centered.],
)
