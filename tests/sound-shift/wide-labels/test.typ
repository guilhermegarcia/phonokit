#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Arrows stop at the edge of labels of any width, in any direction
#sound-shift(
  nodes: (
    (label: "ma", at: (0, 0)),
    (label: "pa", at: (4, 0)),
    (label: "\\t tS \\h a", at: (4, -2.5)),
    (label: "a \\tone{51}", at: (0, -2.5)),
  ),
  arrows: (("ma", "pa"), ("pa", "\\t tS \\h a"), ("\\t tS \\h a", "a \\tone{51}"), ("a \\tone{51}", "ma"), (from: "ma", to: "\\t tS \\h a", curved: true)),
)

// Fills and highlights cover wide labels; an explicit gap is space after the label
#sound-shift(
  nodes: ((label: "ma", at: (0, 0), fill: luma(220)), (label: "pa", at: (3, 0)), (label: "a", at: (6, 0), fill: luma(220))),
  arrows: (("ma", "pa"), (from: "pa", to: "a", start-gap: 0.4, end-gap: 0.05)),
  highlights: ("pa",),
)
