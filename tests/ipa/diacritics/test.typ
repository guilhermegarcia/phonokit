#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

#let bases = ("a", "e", "i", "o", "u", "n", "t", "d", "w", "l")
#let diacritics = ("\\~", "\\r", "\\v", "\\dental", "\\*", "\\h", "\\velar", "\\palatal", "\\labial", "\\ej")
#table(
  columns: 1 + diacritics.len(),
  align: center + horizon,
  inset: 0.5em,
  stroke: 0.4pt + luma(200),
  [], ..diacritics.map(d => text(size: 7pt, raw(d))),
  ..bases.map(b => (raw(b), ..diacritics.map(d => ipa("[ " + d + " " + b + "]")))).flatten(),
)
