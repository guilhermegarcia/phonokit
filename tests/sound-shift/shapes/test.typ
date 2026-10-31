#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Fills and highlights cover the ink of any label: a circle when it fits,
// otherwise a rounded box (descenders, ascenders, marks, tones)
#let labels = ("a", "ga", "bla", "\\:d a", "N", "\\t dZ \\h a", "a \\tone{214}", "\\' a:")
#sound-shift(
  nodes: labels.enumerate().map(((i, l)) => (label: l, at: (calc.rem(i, 4) * 3, -calc.floor(i / 4) * 2.2))),
  arrows: ((labels.at(0), labels.at(1)), (labels.at(1), labels.at(2)), (labels.at(2), labels.at(3)), (labels.at(4), labels.at(5)), (labels.at(5), labels.at(6)), (labels.at(6), labels.at(7)), (labels.at(3), labels.at(7))),
  highlights: labels,
)

// Per-node fill and radius, a highlighted coordinate, explicit gaps, scale
#sound-shift(
  nodes: ((label: "ma", at: (0, 0), fill: luma(200)), (label: "e", at: (3, 0), fill: luma(200), radius: 0.7), (label: "pa", at: (6, 0))),
  arrows: (("ma", "e"), (from: "e", to: "pa", start-gap: 0.4, end-gap: 0)),
  highlights: ((4.5, -1),),
  scale: 0.6,
)
