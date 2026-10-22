#import "/ipa.typ": ipa-to-unicode
#assert.eq(ipa-to-unicode("\\t tS"), "t\u{361}ʃ")
#assert.eq(ipa-to-unicode("\\ae"), "æ")
#assert.eq(ipa-to-unicode("N"), "ŋ")
#assert.eq(ipa-to-unicode("S Z"), "ʃʒ")
#assert.eq(ipa-to-unicode("a \\s b"), "a b")
#assert(ipa-to-unicode("[ \\r w]").contains("w"))
