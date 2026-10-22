#import "/lib.typ": *
#set page(width: 14cm, height: auto, margin: 1em)
#show: ex-rules

#ex()[
  #table(
    columns: (2em, 2em, 5em, 2em, 5em),
    stroke: none, align: left,
    [#ex-num-label()], [#subex-label()<ex-a>], [#ipa("/anba/")], [#a-r], [#ipa("[amba]")],
    [], [#subex-label()<ex-b>], [#ipa("/anka/")], [#a-r], [#ipa("[aNka]")],
  )
]

See @ex-a and @ex-b.
