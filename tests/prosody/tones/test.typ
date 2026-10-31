#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Tone sits on the nucleus: the same tree whether typed before or after the coda
#syllable("man \\tone{51}") #h(1em) #syllable("ma \\tone{51}n") #h(1em) #syllable("waI \\tone{35}") #h(1em) #syllable("\\v m \\tone{21}") #h(1em) #syllable("'ma: \\tone{214}")

// Tone letters add no moras
#mora("man \\tone{51}") #h(1em) #mora("man \\tone{51}", coda: true) #h(1em) #mora("ma: \\tone{214}")

// Geminates still found when a tone is typed between their halves
#foot("'mat \\tone{5}.ta \\tone{3}") #h(1em) #foot-mora("'mat \\tone{5}.ta \\tone{3}", coda: true)

#word("('ma \\tone{55}.ma \\tone{35}).ma \\tone{214}") #h(1em) #word-mora("('man \\tone{55}.ma \\ntone{2}).ma \\tone{214}", coda: true)
