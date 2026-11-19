#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Broad coverage of vowels(): every preset at three scales, nasals, lang-only
// calls, grids and sizes, ten custom strings (plain, nasals, colours), the
// gallery chart, the manual figures, arrows/shift/highlight combinations and
// a font switch. One chart per page; any visual change shows up here.
#let langs = ("spanish", "portuguese", "italian", "english", "french", "german", "japanese", "russian", "arabic", "all")
#let cases = ()

// Every preset at three scales, plus nasals and lang-only calls
#for l in langs {
  for s in (0.4, 0.7, 1.2) { vowels(l, scale: s); pagebreak() }
  vowels(l, nasals: true); pagebreak()
  vowels(lang: l); pagebreak()
  vowels(l, rows: 0, cols: 0); pagebreak()
  vowels(l, rows: 5, cols: 4); pagebreak()
  vowels(l, width: 12, height: 4); pagebreak()
}

// Custom strings (tipa and unicode), nasals
#for s in ("aeiou", "i e a o u", "iyɨʉɯu", "IUE", "\\ae a \\textturnv", "aãioõu", "ĩ ẽ ã õ ũ", "y ø œ ɶ", "ɪ ʏ ʊ", "ə ɐ ɜ ɞ ɘ ɵ") {
  vowels(s); pagebreak()
  vowels(s, nasals: true); pagebreak()
  vowels(s, phoneme-colors: ("i": red, "a": blue, "y": green, "u": orange)); pagebreak()
}

// Gallery image
#vowels(
  "english",
  arrows: (("a", "U"), ("a", "I"), ("e", "I"), ("O", "I"), ("o", "U")),
  arrow-color: blue.lighten(60%),
  curved: true,
  highlight: ("a", "e", "o", "O"),
  highlight-color: blue.lighten(80%),
)
#pagebreak()
// Manual fig-trapezoid-1
#vowels(
  "english",
  arrows: (("a", "U"), ("a", "I"), ("e", "I"), ("O", "I"), ("o", "U")),
  arrow-color: blue.lighten(60%),
  curved: true,
  highlight: ("a", "e", "o", "O"),
  highlight-color: blue.lighten(80%),
  phoneme-colors: ("i": red, "u": orange),
)
#pagebreak()
// Manual fig-trapezoid-2 (both)
#for extra in ((:), (rows: 0, cols: 0, scale: 0.4)) {
  vowels(
    "aeiouIU",
    arrows: (("a", ("U", -0.6, -0.3)), ("a", ("U", -0.3, -0.7))),
    arrow-color: blue.lighten(40%),
    arrow-style: "dashed",
    curved: true,
    shift: (("a", 0.6, 0.3), ("U", -0.6, -0.3), ("U", -0.3, -0.7)),
    shift-size: 1.5em,
    shift-color: blue.darken(20%),
    highlight: ("a", ("U", -0.6, -0.3)),
    highlight-color: blue.lighten(90%),
    ..extra,
  )
  pagebreak()
}
// Straight arrows, highlight sizes, shifted with colors, unknown targets
#vowels("all", arrows: (("i", "u"), ("a", "i"), ("y", "2"), ("e", "o")), highlight: ("i", "y", "a", "@"), circle-size: 1.4)
#pagebreak()
#vowels("all", arrows: (("i", "u"), ("a", "i"), ("y", "2"), ("e", "o"), ("I", "U")), curved: true, arrow-style: "dashed")
#pagebreak()
#vowels("aeiou", arrows: (("i", "y"), ("a", "x")), highlight: ("y", "u"))
#pagebreak()
#vowels("aeiou", shift: (("i", 0.5, -0.3), ("u", -0.4, 0.2)), phoneme-colors: ("i": red), highlight: (("i", 0.5, -0.3),))
#pagebreak()
#vowels("french", nasals: true, highlight: ("a", "o"), arrows: (("a", "o"),), curved: true)
#pagebreak()
#vowels("aãioõu", nasals: true, highlight: ("a",), arrows: (("a", "u"),), curved: true)
#pagebreak()
#set text(font: "New Computer Modern")
#phonokit-init(font: "New Computer Modern")
#vowels("english")
#pagebreak()
#vowels("iyɨʉɯu eø ɛœ aɶ", nasals: true)
