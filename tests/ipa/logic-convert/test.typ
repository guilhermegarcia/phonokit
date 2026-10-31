#import "/ipa.typ": ipa-to-unicode
#assert.eq(ipa-to-unicode("\\t tS"), "t\u{361}ʃ")
#assert.eq(ipa-to-unicode("\\ae"), "æ")
#assert.eq(ipa-to-unicode("N"), "ŋ")
#assert.eq(ipa-to-unicode("S Z"), "ʃʒ")
#assert.eq(ipa-to-unicode("a \\s b"), "a b")
#assert(ipa-to-unicode("[ \\r w]").contains("w"))

// Sinological apical vowel (TIPA name)
#assert.eq(ipa-to-unicode("s \\textlhtlongi"), "sɿ")
#assert.eq(ipa-to-unicode("s \\apicals"), "sɿ")
#assert.eq(ipa-to-unicode("\\:s \\textrhtlongi"), "ʂʅ")
#assert.eq(ipa-to-unicode("\\:s \\apicalr"), "ʂʅ")

// Tone accents (combining, after the base)
#assert.eq(ipa-to-unicode("\\' a"), "a\u{301}")
#assert.eq(ipa-to-unicode("\\` a"), "a\u{300}")
#assert.eq(ipa-to-unicode("\\= a"), "a\u{304}")
#assert.eq(ipa-to-unicode("\\^ a"), "a\u{302}")
#assert.eq(ipa-to-unicode("\\falling a"), "a\u{302}")
#assert.eq(ipa-to-unicode("\\rising a"), "a\u{30C}")
#assert.eq(ipa-to-unicode("\\doubleacute a"), "a\u{30B}")
#assert.eq(ipa-to-unicode("\\doublegrave a"), "a\u{30F}")
#assert.eq(ipa-to-unicode("\\textdoublegrave a"), "a\u{30F}")
#assert.eq(ipa-to-unicode("t \\' E"), "tɛ\u{301}")
// \H stays the archiphoneme
#assert.eq(ipa-to-unicode("\\H"), "H")

// Typed accents: kept as typed on plain letters, kept on top of shortcuts
#assert.eq(ipa-to-unicode("tá"), "tá")
#assert.eq(ipa-to-unicode("ça"), "ça")
#assert.eq(ipa-to-unicode("tÉ"), "tɛ\u{301}")
#assert.eq(ipa-to-unicode("@\u{300}"), "ə\u{300}")
#assert.eq(ipa-to-unicode("Ǐ"), "ɪ\u{30C}")
// Forward diacritics stack
#assert.eq(ipa-to-unicode("\\` \\v m"), "m\u{300}\u{329}")
#assert.eq(ipa-to-unicode("\\~ \\' a"), "a\u{303}\u{301}")
