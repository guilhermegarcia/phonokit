#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Arrow lines pass under every label they cross, even one where another
// arrow starts (a→i under e); heads sit on top of masks and highlights, and
// highlights next to plain labels stay whole
#vowels("aeiou", arrows: (("a", "i"), ("e", "u")), scale: 0.7)
#vowels("all", arrows: (("i", "u"), ("a", "i"), ("e", "o")), highlight: ("i", "y", "a", "@"), scale: 0.6)
