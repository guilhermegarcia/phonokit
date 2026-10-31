#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Commands and typed accents give the same trees
#ipa("[t \\' a \\s t \\` a \\s t \\= a \\s t \\falling a \\s t \\rising a \\s t \\doubleacute a \\s t \\doublegrave a \\s t \\' E]") \
#ipa("[tá tà tā tâ tǎ tÉ]")

#syllable("t \\' a") #syllable("tá") #syllable("tÉn") #mora("t \\rising a n", coda: true)

#word("('t \\' a.t \\` a).tā") #foot-mora("'tâ.ta", coda: true)
