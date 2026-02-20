#import "lib.typ": *
#set page(height: auto, width: auto, margin: (bottom: 1.5em, top: 1.5em, x: 1.5em))
#set text(font: "Charis SIL")

= Arrows

== 1a. Solid arrow — diphthong #ipa("aU") ("out"), straight
#vowels("aU", arrows: (("a", "U"),))

== 1b. Same, curved
#vowels("aU", arrows: (("a", "U"),), curved: true)

== 2. Dashed curved arrow — diphthong #ipa("eI") ("day")
#vowels("eI", arrows: (("e", "I"),), arrow-style: "dashed", curved: true)

== 3. Colored arrow (blue) — diphthong #ipa("aI") ("my")
#vowels("aI", arrows: (("a", "I"),), arrow-color: blue)

== 4. Multiple curved arrows — English diphthongs #ipa("eI"), #ipa("aI"), #ipa("aU"), #ipa("oU")
#vowels(
  "eIaUoO",
  arrows: (
    ("e", "I"),
    ("a", "I"),
    ("a", "U"),
    ("o", "U"),
  ),
  curved: true,
)

== 5. Red dashed arrow — diphthong #ipa("OI") ("boy")
#vowels("OI", arrows: (("O", "I"),), arrow-color: red, arrow-style: "dashed")

== 6. Scale test at 0.4 — same #ipa("aU") arrow, smaller chart
#vowels("aU", arrows: (("a", "U"),), scale: 0.4)

= Shift

== 7. Shift — #ipa("E") raised slightly (default gray)
#vowels("english", shift: (("E", 0.0, 0.5),))

== 8. Shift with red color
#vowels("english", shift: (("E", 0.3, 0.4),), shift-color: red)

== 9. Shift-only vowel — #ipa("@") not in base set, created by shift
#vowels("aeiou", shift: (("@", 0.2, 0.1),))

== 10. Multiple shifts — allophones of #ipa("E") and #ipa("o") in blue
#vowels(
  "english",
  shift: (
    ("E", 0.0, 0.5),
    ("o", -0.3, -0.3),
  ),
  shift-color: blue.lighten(30%),
)

== 11. Shift with smaller font size (10pt)
#vowels("english", shift: (("E", 0.2, 0.3),), shift-size: 10pt)

= Combined: arrows + shift

== 12. Arrow + shift — diphthong #ipa("aU") with shifted allophone of #ipa("a")
#vowels("aU", arrows: (("a", "U"),), shift: (("a", 0.1, 0.25),), shift-color: gray)

== 13. Full English chart with diphthong arrows and allophone shifts
#vowels(
  "english",
  arrows: (
    ("e", "I"),
    ("a", "I"),
    ("a", "U"),
    ("o", "U"),
  ),
  arrow-color: eastern,
  arrow-style: "dashed",
  shift: (
    ("E", 0.0, 0.4),
    ("@", 0.2, 0.0),
  ),
  shift-color: red.lighten(20%),
)

= Highlight

== 16. Highlight three vowels (default light gray)
#vowels("english", highlight: ("E", "o", "i", "@"))

== 17. Highlight with custom color
#vowels("english", highlight: ("e", "a", "u"), highlight-color: red.lighten(80%))

== 18. Highlight + arrows combined
#vowels("english", highlight: ("a", "U"), arrows: (("a", "U"),), curved: true)

== 19. Highlight vowel not in chart — should silently skip
#vowels("aeiou", highlight: ("E", "o"))

= Arrows between shifted vowels

== 20. Arrow between two shifted vowels
#vowels("aU", shift: (("a", 0.3, 0.4), ("U", -0.3, 0.3)), arrows: ((("a", 0.3, 0.4), ("U", -0.3, 0.3)),), curved: true)

== 21. Arrow from canonical vowel to a shifted one
#vowels("english", shift: (("E", 0.4, 0.5),), arrows: (("e", ("E", 0.4, 0.5)),))

= Edge cases

== 14. Arrow with one unknown symbol — should skip silently
#vowels("ai", arrows: (("a", "X"),))

== 15. Shift with unknown symbol — should skip silently
#vowels("ai", shift: (("X", 0.5, 0.5),))
