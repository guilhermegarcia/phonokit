#import "/vowels.typ": _collect-custom-vowels, _resolve-variant

#let nfd(keys) = keys.map(k => k.normalize(form: "nfd"))

// Oral and nasal lengths are tracked apart: "ã:" lengthens the nasal copy only
#let parsed = _collect-custom-vowels("i i: ã: e")
#assert.eq(parsed.variants.i, ("i", "iː"))
#assert.eq(parsed.variants.a, ("a",))
#assert.eq(parsed.variants.e, ("e",))
#assert.eq(nfd(parsed.nasal-variants.a), nfd(("ãː",)))
#assert.eq(parsed.rejected, ())

// "i:" names the long variant and never the short "i" plotted beside it
#assert.eq(_resolve-variant(parsed.variants, "iː"), ("i", 1))
#assert.eq(_resolve-variant(parsed.variants, "i"), ("i", 0))
// A length the vowel doesn't have matches nothing
#assert.eq(_resolve-variant(parsed.variants, "eː"), none)
// A bare vowel doesn't match its long variant, even when no short one is plotted
#let long-only = _collect-custom-vowels("i:").variants
#assert.eq(_resolve-variant(long-only, "i"), none)
#assert.eq(_resolve-variant(long-only, "iː"), ("i", 0))
// Unplotted vowels resolve to nothing
#assert.eq(_resolve-variant(parsed.variants, "u"), none)

// Orphan length marks are kept apart from unknown symbols
#let orphan = _collect-custom-vowels(": a")
#assert.eq(orphan.orphans, ("ː",))
#assert.eq(orphan.rejected, ())
#assert.eq(_collect-custom-vowels("i:: e").orphans, ("ː",))
#assert.eq(_collect-custom-vowels("ˑ a ː").orphans, ("ˑ",))
// "ˑ a ː": the trailing mark attaches to a (spaces only separate tokens)
#assert.eq(_collect-custom-vowels("ˑ a ː").variants.a, ("aː",))
#assert.eq(_collect-custom-vowels("p: a").orphans, ())
#assert.eq(_collect-custom-vowels("p: a").rejected, ("p",))
#assert.eq(_collect-custom-vowels("i: a").orphans, ())
