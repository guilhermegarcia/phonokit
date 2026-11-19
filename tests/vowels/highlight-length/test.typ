#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Highlights and arrows centre on the whole long label (iː), not its base
// glyph: long-only vowels, a variant, and a shifted copy
#vowels("i: e a u:", highlight: ("i:", "u:", ("i:", 0.6, -2.4)),
  arrows: (("i:", "u:"), ("i:", ("i:", 0.6, -2.4))),
  shift: (("i:", 0.6, -2.4),), scale: 0.6)
#vowels("o oː", highlight: ("o", "o:"), scale: 0.6)
