#import "/lib.typ": *
#set page(width: 16cm, height: auto, margin: 0.5em)

// Errors name the problem: unknown symbols, unknown commands (as typed), unknown language
#vowels("a e p t") \
#vowels("a \\tone{5} i") \
#vowels("a \\xyz i") \
#vowels(lang: "klingon") \
// Length marks with no vowel before them: not "unknown symbol"
#vowels(": a") \
#vowels("i:: e") \
#vowels("ˑ a ː") \
#vowels("ˑ :: a") \
// A mark after an unknown symbol is reported through that symbol
#vowels("p: a")
