#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Regression: no line break right after an opening slash
#set par(justify: true)
#for w in (122pt, 146pt, 206pt, 226pt) {
  block(width: w, stroke: 0.4pt + gray, inset: 3pt)[In French, for example, #ipa("/ɥ/") competes with #ipa("/w/") for the bilabial approximant cell and with #ipa("/j/") for the palatal one. On the right, #ipa("/ʍ/") competes with #ipa("/x/") for the voiceless velar fricative cell.]
}
#block(width: 120pt, stroke: 0.4pt + gray, inset: 3pt)[A long phrase: #ipa("/ri \\s na \\s kaza \\s du \\s paj/") wraps at its spaces.]
