#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.6em)

// Nasal copies clear the oral glyph below them: the dot of i/ɨ, the slash
// of ø and the descender of ỹ lift their whole row of copies, which stays
// level (ũ rises with ĩ). Rows of x-height vowels keep the default offset.
#vowels("ĩ ɨ̃ ỹ ũ ẽ ø̃ õ ɛ̃ ã", nasals: true, scale: 0.6)
// With length marks
#vowels("i i: ĩ ĩ: y y: ỹ", nasals: true, scale: 0.6)
