#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Arrays: IPA by default; ipa: false keeps text literal but still converts tones
#met-grid(("ma \\tone{55}", 3), ("ma \\tone{35}", 1), ("ma \\tone{214}", 2))
#met-grid(("ma\\tone{55}", 2), ("S", 1), ipa: false)

// Strings: tones by default, full IPA only with ipa: true
#met-grid("ma\\tone{55}3.ma\\tone{35}1")
#met-grid("Si3.t \\h a\\tone{51}1", ipa: true)
#met-grid("te2.ne1.see3.Ti3.tans1")
