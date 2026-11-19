#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// A straight arrow is drawn only if its head fits between the two circles.
// æ→a and ɜ→ə (the shortest real neighbours) are drawn; with highlighted
// ends the circles are bigger, so æ→a is skipped
#vowels("i e ə ɜ æ a", arrows: (("æ", "a"), ("ɜ", "ə")), scale: 0.6)
#vowels("i e ə ɜ æ a", arrows: (("æ", "a"), ("i", "e")), highlight: ("æ", "a", "i", "e"), scale: 0.6)
// Side-by-side labels get a U under them (default curved: auto);
// with curved: false the straight i→iː is too short and skipped
#vowels("i i: e e: u", arrows: (("i", "i:"), ("e:", "e")), scale: 0.6)
#vowels("i i: e e: u", arrows: (("i", "i:"), ("e:", "e")), curved: false, scale: 0.6)
