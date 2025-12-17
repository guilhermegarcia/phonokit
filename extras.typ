
// NOTE: -- Function for feature matrices in SPE
#let feat(..args) = {
  let items = args.pos()

  // 1. Split string if comma-separated
  if items.len() == 1 and type(items.at(0)) == str and items.at(0).contains(",") {
    items = items.at(0).split(",")
  }

  // 2. Style the items (Charis SIL + Larger Size)
  let features = items.map(i => {
    let content = if type(i) == str { i.trim() } else { i }
    // Set font to Charis SIL and size to normal (1em) or larger (e.g., 1.1em)
    text(font: "Charis SIL", size: 1em, content)
  })

  // 3. Use math.vec for perfect axis alignment
  set math.vec(gap: 0.5em)
  math.vec(delim: "[", ..features)
}

// NOTE: -- A collection of arrows
#let aR = text(font: "New Computer Modern", size: 1.5em)[#h(1em)#sym.arrow.r#h(1em)]
#let ar = text(font: "New Computer Modern", size: 2em)[#sym.arrow.r]
#let al = text(font: "New Computer Modern")[#sym.arrow.l]
#let au = text(font: "New Computer Modern")[#sym.arrow.t]
#let ad = text(font: "New Computer Modern")[#sym.arrow.b]
#let aud = text(font: "New Computer Modern")[#sym.arrow.t.b]
#let alr = text(font: "New Computer Modern")[#sym.arrow.l.r]
#let asr = text(font: "New Computer Modern")[#sym.arrow.r.squiggly]
#let asl = text(font: "New Computer Modern")[#sym.arrow.l.squiggly]

// NOTE: -- Function for context underline
#let blank(width: 2em) = box(
  width: width,
  height: 0.8em,
  baseline: 50%,
  stroke: (bottom: 0.5pt + black)
)


