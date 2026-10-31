#import "/lib.typ": *
#set page(width: 16cm, height: auto, margin: 0.5em)

// Errors name the problem: unknown symbols, unknown commands (as typed), unknown language
#vowels("a e p t") \
#vowels("a \\tone{5} i") \
#vowels("a \\xyz i") \
#vowels(lang: "klingon")
