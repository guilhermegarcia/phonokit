#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Tones in the functions that render IPA labels
#multi-tier(levels: (("sigma", "sigma"), ("ma \\tone{55}", "ma \\tone{214}\\tone{214}")), links: (((0, 0), (1, 0)), ((0, 1), (1, 1))), ipa: (1,))
#ex[#ipa("/ma \\tone{214} ma \\tone{214}/") & #a-r & #ipa("[ma \\tone{35} ma \\tone{214}]")]
#vot(60, vowel-segment: "a \\tone{51}", closure-segment: "t")
#ipa("ma \\tone{214}")#int("L*") #ipa("t \\' a")#int("H%", line: false)

// Not segments: rejected or reported
#feat-matrix("a \\tone{5}") \
#vowels("a \\tone{5} i u")
