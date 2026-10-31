#import "/ipa.typ": as-typed, unknown-commands

// Messages show commands as typed in a Typst string: \\v, never \v
#assert.eq(as-typed("\\v"), "\\\\v")
#assert.eq(as-typed("t \\* \\* a"), "t \\\\* \\\\* a")
#assert.eq(as-typed("ma"), "ma")

// Unknown commands are found whole, as typed
#assert.eq(unknown-commands("p \\xyz a"), ("\\xyz",))
#assert.eq(unknown-commands("('\\ae.\\xyz)"), ("\\xyz",))
#assert.eq(unknown-commands("a \\xyz \\xyz"), ("\\xyz",))
#assert.eq(unknown-commands("t\\h a"), ("t\\h",))
#assert.eq(unknown-commands("{tɕ \\xyz}{tS \\h}"), ("\\xyz",))
// Known commands, including ones with braces, stress, tones and accents
#assert.eq(unknown-commands("t \\' a.ta"), ())
#assert.eq(unknown-commands("{\\t ts} \\c{c} \\v{z} \\v{\\j} p"), ())
#assert.eq(unknown-commands("ptkfsɕʑ {tɕ}{dʑ}{tɕ \\h}{tS \\h}"), ())
#assert.eq(unknown-commands("ma \\tone{51} \\' a \\rising a \\apicals"), ())
#assert.eq(unknown-commands("\\t tS \\h a: \\textlhtlongi \\apicalr"), ())
