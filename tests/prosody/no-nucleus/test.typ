#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// A syllable without a vowel or syllabic consonant gets a warning, not an empty N
#syllable("pf") \
#syllable("pf \\tone{5}") \
#mora("pf", coda: true) \
#foot("'ma.pf") \
#foot-mora("'ma.pf") \
#word("('ma.ta).pf") \
#word-mora("('ma.ta).pf")

// Syllabic consonants are nuclei: no warning
#syllable("\\v m \\tone{21}") #mora("p \\v s")

// Onset-rhyme trees can draw an empty N instead (moraic trees cannot)
#syllable("pf", empty-nucleus: true) #syllable("pf \\tone{5}", empty-nucleus: true) #foot("'ma.pf", empty-nucleus: true) #word("('ma.ta).pf", empty-nucleus: true) \
#mora("pf", coda: true)

// Sinological apical vowels are nuclei
#syllable("s \\textlhtlongi \\tone{51}") #syllable("\\:s \\apicalr \\tone{51}") #mora("s \\textlhtlongi")
