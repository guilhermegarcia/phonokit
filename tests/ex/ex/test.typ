#import "/lib.typ": *
#set page(width: 14cm, height: auto, margin: 1em)
#show: ex-rules

#ex(caption: "A phonology example", labels: (<ex-anba>, <ex-anka>), columns: (5em, 2em, 5em))[
  - #ipa("/anba/") & #a-r & #ipa("[amba]")
  - #ipa("/anka/") & #a-r & #ipa("[aNka]")
] <phon-ex>

#ex[A single example without sub-examples.] <single>

See @phon-ex, @ex-anka and @single.
