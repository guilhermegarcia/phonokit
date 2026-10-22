#import "/consonants.typ": categorize-braced-items
#let r = categorize-braced-items(("tʂ", "dʐ", "tʂ \\h"))
#assert.eq(r.affricates, ("ʈʂ", "ɖʐ"))
#assert.eq(r.aspirated-affricates, ("ʈʂʰ",))
#assert.eq(r.rejected, ())
