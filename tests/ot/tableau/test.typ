#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

#tableau(
  input: "kraTa",
  candidates: ("kra.Ta", "ka.Ta", "ka.ra.Ta"),
  constraints: ("Max", "Dep", "*Complex"),
  violations: (("", "", "*"), ("*!", "", ""), ("", "*!", "")),
  winner: 0,
  dashed-lines: (0,),
)
