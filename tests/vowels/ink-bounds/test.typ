#import "/lib.typ": *
// No margin: anything outside the chart's box would be cut off
#set page(width: auto, height: auto, margin: 0pt)

// Nasal tildes above the top row, the dot of i, a shifted copy with a descender
#vowels("ĩ ỹ ũ ɛ̃ ã", nasals: true, shift: (("y", 0.6, -4.2),), scale: 0.6)
