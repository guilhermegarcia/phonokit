#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

#let kinds = ("\\tone", "\\ltone", "\\ntone", "\\nltone")
#let levels = ("5", "4", "3", "2", "1", "55", "35", "51", "214", "53", "13")
#table(
  columns: 1 + kinds.len(),
  align: center + horizon,
  inset: 0.5em,
  stroke: 0.4pt + luma(200),
  [], ..kinds.map(k => text(size: 7pt, raw(k))),
  ..levels.map(l => (raw(l), ..kinds.map(k => ipa("ma " + k + "{" + l + "}")))).flatten(),
)

#ipa("[ma \\tone{55} \\s ma \\tone{35} \\s ma \\tone{214} \\s ma \\tone{51} \\s ma \\ntone{2}]") \
#ipa("/ \\t ts \\h a \\tone{51}/")
