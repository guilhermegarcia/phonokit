#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Arrows to and from a variant with a sibling ("uː" in "u uː") stop at that
// label's own box, so the head never lands on the sibling; curved arrows
// pick an arc whose head stays off other labels
#vowels("i iː e eː a aː o oː u uː", arrows: (("a:", "i:"), ("a:", "u:"), ("e", "i:"), ("o", "u:")), curved: true, scale: 0.7)
#vowels("i iː e eː a aː o oː u uː", arrows: (("a:", "i:"), ("a:", "u:"), ("e", "i:"), ("o", "u:")), scale: 0.7)
