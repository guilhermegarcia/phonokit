#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

#tableau(
  input: "ma \\tone{214} ma \\tone{214}",
  candidates: ("ma \\tone{35} ma \\tone{214}", "ma \\tone{214} ma \\tone{214}"),
  constraints: ("OCP-T3", "Ident-T"),
  violations: (("", "*"), ("*!", "")),
  winner: 0,
)

// Tone braces vs raw-text braces, scripts, and tones in constraint names
#tableau(
  input: "ma \\tone{214}_{T3} {(raw)}",
  candidates: ("ma \\tone{35}^{T2}", "#syllable('ma \\tone{35}')"),
  constraints: ("*\\tone{214}", "Max[\\tone{5}]"),
  violations: (("", ""), ("", "*")),
  winner: 0,
)

#hg(
  input: "ma \\tone{214}",
  candidates: ("ma \\tone{35}", "ma \\tone{214}"),
  constraints: ("*T3", "Ident"),
  weights: (2, 1),
  violations: ((0, 1), (1, 0)),
)

// Scripts after accented vowels stay clear of the accent; \^ is a tone, ^{} a superscript
#tableau(
  input: "t \\^ a^{x}",
  candidates: ("t \\' a_{H}", "tà^{L}"),
  constraints: ("Max-H",),
  violations: (("",), ("*!",)),
  winner: 0,
)
