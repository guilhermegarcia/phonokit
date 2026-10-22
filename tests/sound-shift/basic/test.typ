#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

#sound-shift(
  nodes: (
    (label: "I", at: (-4.2, 2.8)),
    (label: "E", at: (-1.9, 1.0)),
    (label: "2", at: (0.9, 1.0)),
    (label: "O", at: (3.8, 1.0)),
    (label: "A", at: (2.4, -1.5)),
    (label: "\\ae", at: (-1.0, -1.5)),
  ),
  arrows: (
    ("E", "2"),
    ("2", "O"),
    ("O", "A"),
    ("A", "\\ae"),
    ("I", "E"),
    (from: "\\ae", to: "I", curved: true, curve: 0.28),
  ),
  scale: 0.7,
)
