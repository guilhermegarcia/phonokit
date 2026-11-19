#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// An arrow between a vowel and its own long form loops wider than the two
// labels (a circular "reset" arrow), below them by default and in both
// directions; when a minimal-pair U already runs under that vowel, the loop
// goes over the top
#vowels("i i: e e: a a: u u:", arrows: (("i", "i:"), ("e:", "e"), ("a", "a:"), ("u", "u:")), scale: 0.7)
#vowels("i i: y y: e ø", arrows: (("i", "i:"), ("y", "i"), ("y:", "y")), highlight: ("i:",), scale: 0.7)
#vowels("i i: e e:", arrows: (("i", "i:"), ("e:", "e")), arrow-style: "dashed", scale: 0.5)
