#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// nasals: auto (default) turns the nasal layer on when a custom string
// writes a nasal vowel; presets stay oral; false forces it off
#vowels("a ã: o", scale: 0.5)
#vowels("aãioõu", scale: 0.5)
#vowels("aãioõu", nasals: false, scale: 0.5)
#vowels("french", scale: 0.5)
