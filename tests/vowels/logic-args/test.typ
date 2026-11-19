#import "/lib.typ": *
#assert-panic(() => vowels("aeiou", higlight: ("a",)))
// highlight-style takes only "gradient" or "solid"
#assert-panic(() => vowels("aeiou", highlight-style: "soft"))
#assert-panic(() => vowels("aeiou", nasals: "yes"))
#assert-panic(() => vowels("aeiou", curved: "yes"))
#assert-panic(() => vowels("aeiou", arrows: (("a", "i"),), arrow-head: "fancy"))
