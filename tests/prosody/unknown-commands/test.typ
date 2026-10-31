#import "/lib.typ": *
#set page(width: 16cm, height: auto, margin: 0.5em)

// An unknown command is reported whole, not drawn letter by letter
#syllable("p \\xyz a") \
#mora("t\\h a") \
#foot("'ta.\\xyz a") \
#word("('ta.ta).\\ea") \
#foot-mora("'ta.ta \\qq") \
#word-mora("(ta.'\\zz a)")

// Inside a tableau: the short note
#tableau(input: "/ta/", candidates: ("#syllable('t \\xyz a')",), constraints: ("C",), violations: (("",),), winner: 0)
