#import "/lib.typ": *

// ipa must be auto, true or false
#assert-panic(() => met-grid("ta1", ipa: "yes"))
#assert-panic(() => met-grid(("ta", 1), ipa: 1))
