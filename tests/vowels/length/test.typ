#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Length marks (: or ː, and ˑ) attach to the preceding vowel. The base glyph
// keeps its position; the mark hangs to its right.
#vowels("i: y e a: o u:", scale: 0.5)

// Short and long of the same quality are shown side by side; the rounded
// partner of i moves right so the pair bullet stays clear of "i iː"
#vowels("i i: y a a: e eˑ u u:", scale: 0.5)

// Nasal length belongs to the nasal copy: the oral a stays plain, the copy reads "ã ãː"
#vowels("a ã ã: o", nasals: true, scale: 0.5)

// Variants are independent characters: only iː is highlighted (not the short
// i), only uː is red, and only the short i is blue
#vowels("i i: u u:", highlight: ("i:",), phoneme-colors: ("u:": red, "i": blue), scale: 0.5)

// A bare vowel doesn't match its long variant: nothing is highlighted
#vowels("i: e", highlight: ("i",), scale: 0.5)
