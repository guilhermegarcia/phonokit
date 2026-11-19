#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Default: soft gradient circles (radius 0.6, solid core, fading edge);
// arrows stop mid-fade
#vowels("i y e a o u", highlight: ("i", "y", "a"), arrows: (("a", "u"),), scale: 0.5)
// Solid: hard-edged circles (radius 0.45); arrows stop at the edge
#vowels("i y e a o u", highlight: ("i", "y", "a"), arrows: (("a", "u"),), highlight-style: "solid", scale: 0.5)
// circle-size scales either style
#vowels("i e a o u", highlight: ("i", "a"), circle-size: 0.7, scale: 0.5)
#vowels("i e a o u", highlight: ("i", "a"), circle-size: 0.7, highlight-style: "solid", scale: 0.5)
// A gradient highlight-color can't fade out: drawn solid
#vowels("i e a o u", highlight: ("a",), highlight-color: gradient.linear(red, blue), scale: 0.5)
