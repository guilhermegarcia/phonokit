#import "/lib.typ": *

// Long non-ASCII constraint names are truncated by character, never mid-character
#tableau(
  input: "ma \\tone{214}",
  candidates: ("ma \\tone{35}",),
  constraints: ("*\\tone{214}\\tone{214}\\tone{214}\\tone{214}\\tone{214}", "Ident-ɿʅɿʅɿʅɿʅɿʅɿʅɿʅɿʅɿʅ"),
  violations: (("", ""),),
  winner: 0,
)
#hg(input: "a", candidates: ("ŋ̍ŋ̍ŋ̍ŋ̍ŋ̍ŋ̍ŋ̍ŋ̍ŋ̍",), constraints: ("Max-ŋ̍ŋ̍ŋ̍ŋ̍ŋ̍ŋ̍ŋ̍ŋ̍ŋ̍ŋ̍",), weights: (1,), violations: ((0,),))
