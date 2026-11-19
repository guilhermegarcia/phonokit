#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Arrows converging on one vowel fan out: each keeps its own head, spread
// around the target's edge in arrival order. Each head is aligned with the
// end of its line (no kink on tight curves)
#vowels("english", arrows: (("a", "I"), ("e", "I"), ("O", "I"), ("i", "I"), ("U", "I")), scale: 0.6)
#vowels("english", arrows: (("a", "I"), ("e", "I"), ("O", "I"), ("i", "I"), ("U", "I")), curved: true, highlight: ("I",), scale: 0.6)
#vowels("i iː e eː a aː o oː u uː", arrows: (("a:", "i:"), ("a:", "u:"), ("e", "i:"), ("o", "u:")), curved: true, scale: 0.6)
