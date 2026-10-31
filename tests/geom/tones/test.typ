#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// The preset ignores the tone; the label keeps it
#geom(ph: "a \\tone{5}") #geom(ph: "a: \\tone{51}")
#geom-group((ph: "m"), (ph: "a \\tone{5}"))
