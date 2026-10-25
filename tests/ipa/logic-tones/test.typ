#import "/ipa.typ": ipa-to-unicode

// Level tones, highest (5) to lowest (1), in each of the four sets
#assert.eq(ipa-to-unicode("\\tone{54321}"), "˥˦˧˨˩")
#assert.eq(ipa-to-unicode("\\ltone{54321}"), "꜒꜓꜔꜕꜖")
#assert.eq(ipa-to-unicode("\\ntone{54321}"), "꜈꜉꜊꜋꜌")
#assert.eq(ipa-to-unicode("\\nltone{54321}"), "꜍꜎꜏꜐꜑")
#assert.eq(ipa-to-unicode("\\tone{5}"), "\u{02E5}")
#assert.eq(ipa-to-unicode("\\ltone{5}"), "\u{A712}")
#assert.eq(ipa-to-unicode("\\ntone{3}"), "\u{A70A}")
#assert.eq(ipa-to-unicode("\\nltone{3}"), "\u{A70F}")

// Contours (any length)
#assert.eq(ipa-to-unicode("\\tone{35}"), "˧˥")
#assert.eq(ipa-to-unicode("\\tone{214}"), "˨˩˦")
#assert.eq(ipa-to-unicode("\\tone{5353}"), "˥˧˥˧")

// Attached to a word, separate token, and with other TIPA input
#assert.eq(ipa-to-unicode("ma\\tone{51}"), "ma˥˩")
#assert.eq(ipa-to-unicode("ma \\tone{51}"), "ma˥˩")
#assert.eq(ipa-to-unicode("[ \\t ts a\\tone{214}]"), "[t\u{361}sa˨˩˦]")
#assert.eq(ipa-to-unicode("ma\\tone{55} \\s ma\\tone{35}"), "ma˥˥ ma˧˥")
#assert.eq(ipa-to-unicode("\\~ a\\tone{3}"), "a\u{303}˧")
#assert.eq(ipa-to-unicode("t \\h a\\tone{51}"), "tʰa˥˩")
#assert.eq(ipa-to-unicode("ta\\tone{2}\\ntone{2}"), "ta˨꜋")

// Raw Unicode tone letters pass through unchanged
#assert.eq(ipa-to-unicode("ma˥˩"), "ma˥˩")

// Digits outside \tone{} keep their usual meaning (3 = ɜ)
#assert.eq(ipa-to-unicode("3\\tone{3}"), "ɜ˧")

// Invalid levels
#assert-panic(() => ipa-to-unicode("\\tone{}"))
#assert-panic(() => ipa-to-unicode("\\tone{6}"))
#assert-panic(() => ipa-to-unicode("\\tone{0}"))
#assert-panic(() => ipa-to-unicode("\\ltone{H}"))
#assert-panic(() => ipa-to-unicode("\\tone{5 1}"))
