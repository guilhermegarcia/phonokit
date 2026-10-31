#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// One \tone{} command = one tone: adjacent commands are drawn apart (˨˩˦ ˨˩˦),
// a single command with the same levels is one contour
#ipa("[ma \\tone{214}\\tone{214}] [ma \\tone{55} \\tone{11}] [ma \\tone{5511}]")

#tableau(
  input: "ma \\tone{214} ma \\tone{214}",
  candidates: ("ma \\tone{214}\\tone{214}",),
  constraints: ("*\\tone{214}\\tone{214}", "Max[\\tone{5}\\tone{1}]"),
  violations: (("*", ""),),
  winner: 0,
)

#syllable("ma \\tone{214}\\tone{214}") #sonority("ma \\tone{214}\\tone{214}")
#autoseg(("m", "a"), features: ("", "\\tone{5}\\tone{1}"), tone: true)
#met-grid("ma\\tone{55}\\tone{11}2.ma1")
