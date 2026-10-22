#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Regression: every mask is drawn before any highlight, so a shifted vowel's
// mask never cuts a neighbouring highlight circle
#vowels(
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
  scale: 0.6,
)
