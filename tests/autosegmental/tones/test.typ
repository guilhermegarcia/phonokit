#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Tone commands in tier labels give Chao letters; other labels stay as typed
#autoseg(("m", "a", "m", "a"), features: ("", "\\tone{5}", "", ("\\tone{5}", "\\tone{1}")), tone: true)
#autoseg(("ma \\tone{51}", "ma \\tone{35}"), features: ("H", "L"), tone: true)
