#import "/phonetics.typ": _normalize-vowel-string

// formants() ignores length. ";" is the TIPA half-long shortcut (ˑ), so a
// "i;e;a" list still splits once the marks are dropped
#assert.eq(_normalize-vowel-string("i;e;a"), ("i", "e", "a"))
#assert.eq(_normalize-vowel-string("i: e a:"), ("i", "e", "a"))
#assert.eq(_normalize-vowel-string("iː eˑ a"), ("i", "e", "a"))
#assert.eq(_normalize-vowel-string("i e a"), ("i", "e", "a"))
#assert.eq(_normalize-vowel-string("/i/ [e] |a|"), ("i", "e", "a"))
