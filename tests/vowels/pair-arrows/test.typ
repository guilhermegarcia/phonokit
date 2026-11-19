#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Arrows between a minimal pair run under the bullet as a U (curved: auto),
// in both directions, with highlights, dashed, and across long variants;
// other arrows stay straight. curved: true keeps the U for pairs, and
// curved: false draws them straight
#vowels("i y e ø ɛ œ a ɶ u", arrows: (("i", "y"), ("ø", "e"), ("a", "u")), highlight: ("i", "e"), scale: 0.6)
#vowels("ɨ ʉ ɯ u ʌ ɔ", arrows: (("u", "ɯ"), ("ʌ", "ɔ"), ("ɨ", "ʉ")), arrow-style: "dashed", scale: 0.6)
#vowels("i i: y y: e ø", arrows: (("i:", "y:"), ("e", "i")), curved: true, scale: 0.6)
#vowels("i y e ø", arrows: (("i", "y"),), curved: false, scale: 0.6)
// With curved: false, a straight arrow across a pair replaces its bullet;
// pairs without an arrow keep theirs
#vowels("i i: y e e: ø a", arrows: (("i:", "y"), ("a", "e")), curved: false, scale: 0.6)
