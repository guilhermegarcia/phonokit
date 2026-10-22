#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Positions follow drawn order: 0 Bilabial ... 5 Retroflex, 6 Alveolo-palatal, 7 Palatal ... 11 Glottal
#let all(..a) = consonants("all", affricates: true, aspirated: true, abbreviate: true, scale: 0.45, ..a)
#all(delete-cols: (6,))
#all(delete-cols: (5, 7))
#all(delete-cols: (11,))
#all(delete-cols: (0, 1, 2, 3, 4, 5, 6))
#consonants("english", delete-cols: (7,), scale: 0.45)
// Ignored positions: both tables must match the default English table
#consonants("english", delete-cols: (-1, 12), scale: 0.45)
#consonants("english", scale: 0.45)
