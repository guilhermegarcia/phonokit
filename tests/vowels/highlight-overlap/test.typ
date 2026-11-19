#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// A highlight next to a plain label stays whole when an arrow is drawn:
// the plain label's mask never cuts into it (shifted i next to a highlighted
// shifted iː; oral a under a highlighted nasal ãː)
#vowels("i i: u", shift: (("i", 0, -1.4), ("i:", 0, -1.4)),
  highlight: (("i:", 0, -1.4),), arrows: (("i:", ("i:", 0, -1.4)),), scale: 0.7)
#vowels("i a ã: u", highlight: ("ã:",), arrows: (("i", "ã:"),), scale: 0.7)
