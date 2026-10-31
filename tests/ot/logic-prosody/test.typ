#import "/ot.typ": prosody-pattern

#let calls(s) = s.matches(prosody-pattern).map(m => m.captures)

// The argument ends at the first '), so stress marks can be used inside
#assert.eq(calls("#word('('po.Ra).ma')"), (("word", "('po.Ra).ma"),))
#assert.eq(calls("#foot(''ta.ta')"), (("foot", "'ta.ta"),))
#assert.eq(calls("#foot('ta.'ta')"), (("foot", "ta.'ta"),))
#assert.eq(calls("#word('(,ta.ta)('ta.ta)')"), (("word", "(,ta.ta)('ta.ta)"),))
#assert.eq(calls("#foot-mora('ta.'tan')"), (("foot-mora", "ta.'tan"),))
#assert.eq(calls("#word-mora('('ta.ta).ta')"), (("word-mora", "('ta.ta).ta"),))
// \' (high tone) inside a candidate
#assert.eq(calls("#syllable('t \\' a')"), (("syllable", "t \\' a"),))
// Several calls in one string, each ending at its own ')
#assert.eq(calls("#syllable('ta') + #syllable('pa')"), (("syllable", "ta"), ("syllable", "pa")))
#assert.eq(calls("#foot(''ta.ta') + #foot('ta.'ta')"), (("foot", "'ta.ta"), ("foot", "ta.'ta")))
// Inputs without stress read as before
#assert.eq(calls("#mora('kan')"), (("mora", "kan"),))
#assert.eq(calls("plain text"), ())
