#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// , marks secondary stress: never a segment, and it heads its foot.
// The foot with ' heads ω, whatever foot: says
#word("('ta.ta)(,ta.ta)") #word("(,ta.ta)('ta.ta)", foot: "L") #word-mora("(,ta.ta)('ta.ta)", foot: "R")

// , heads a foot on either side
#foot(",ta.ta") #foot-mora("ta.,tan", coda: true)

// Without feet, only ' places ω
#word(",ta.ta.'ta") #word-mora("'ta.ta.,ta")
