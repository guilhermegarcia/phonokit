#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// A candidate that would warn shows only "Ill-formed: see manual"
#tableau(
  input: "/tata/",
  candidates: ("#foot(''ta.ta')", "#foot(''ta.'ta')", "#word('(,'ta.ta)')", "#syllable('pf')", "#mora('pf')", "#syllable('t \\* \\* a')"),
  constraints: ("Clash",),
  violations: (("",), ("*!",), ("*!",), ("*!",), ("*!",), ("*!",)),
  winner: 0,
)

// Outside tableaux, the full warning
#foot("'ta.'ta")

// Content candidates: any call, with any options (their own warnings are full)
#tableau(
  input: "/tanta/",
  candidates: ([#foot-mora("'tan.ta", coda: true, scale: 0.5)], [#word("('tan.ta)", scale: 0.5)]),
  constraints: ("WbP",),
  violations: (("",), ("*!",)),
  winner: 0,
)
