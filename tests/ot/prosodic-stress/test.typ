#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Primary stress inside prosodic candidates
#tableau(
  input: "/pomaRa/",
  candidates: ("#word('('po.ma).Ra')", "#word('po.('ma.Ra)')", "#foot(''po.ma') + #syllable('Ra')"),
  constraints: ("Align-L", "Parse-σ"),
  violations: (("", "*"), ("*!", "*"), ("", "*")),
  winner: 0,
)

#hg(
  input: "/tata/",
  candidates: ("#foot(''ta.ta')", "#foot('ta.'ta')"),
  constraints: ("Trochee", "Iamb"),
  weights: (2, 1),
  violations: ((0, -1), (-1, 0)),
)
