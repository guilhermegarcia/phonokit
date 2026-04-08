#import "lib.typ": *

//
// #strong[Negative VOT] #h(1em) #vot(-60)
//
// #strong[Zero VOT] #h(1em) #vot(0)
//
// #strong[Positive VOT] #h(1em) #vot(8)
//
// #strong[Portuguese labels] #h(1em) #vot(-60, ui-lang: "pt")
//
// #strong[French labels] #h(1em) #vot(-37, ui-lang: "fr")

Testing a figure.

#figure(
  caption: [test],
  gap: 1em,
)[
  #vot(
    60,
    closure: 33,
    vowel: 46,
    scale: 1.0,
    label: auto,
    keys: false,
    ui-lang: "en",
    closure-label: auto,
    release-label: auto,
    voicing-label: auto,
    vowel-label: auto,
    vot-label: auto,
    interval-label: auto,
    interval-key: auto,
    closure-segment: none,
    interval-segment: none,
    vowel-segment: none,
    segment-size: 10pt,
    fill-closure: luma(230),
    fill-vowel: white,
    fill-aspiration: luma(245),
    voicing: true,
    voicing-stroke: auto,
  )
]
