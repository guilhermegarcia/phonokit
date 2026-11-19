#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Nasal copies are targets: highlight, colour and arrows reach "ã" and "ã:"
// by exact key, precomposed or with a combining tilde
#vowels("i a ã: o õ u", highlight: ("ã:", "õ"), phoneme-colors: ("ã:": red, "õ": blue),
  arrows: (("i", "ã:"), ("õ", "u")), scale: 0.6)
// Preset nasal copies (French) too; "ɛ̃" written with \~
#vowels("french", nasals: true, highlight: ("\\~ E",), arrows: (("a", "\\~ E"),), scale: 0.6)
