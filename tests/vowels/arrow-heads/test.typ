#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Every arrow-head option (default: curved-stealth), solid and dashed
#for h in ("curved-stealth", "stealth", "triangle", "barbed", "straight") {
  vowels("aeiou", arrows: (("a", "i"), ("e", "u")), arrow-head: h, scale: 0.4)
  vowels("aeiou", arrows: (("a", "i"),), arrow-head: h, arrow-style: "dashed", curved: true, scale: 0.4)
  linebreak()
}
