#import "_config.typ": phonokit-font

/// Place a ToBI label above the current inline text position
///
/// Designed to be placed inline immediately after the syllable or word being annotated.
/// The label floats above the text at the insertion point, optionally connected by
/// a vertical stem.
///
/// Arguments:
/// - label (string): ToBI label, e.g., "*L", "H%", "L+H*", "!H*"
/// - line (boolean): draw a vertical stem connecting label to text (default: true)
/// - height (length): stem length — controls how far above the text the label sits (default: 1.5em)
/// - lift (length): gap between stem bottom and text baseline (default: 0.4em)
///
/// Example:
/// ```
/// #import "@preview/phonokit:0.4.5": *
/// You're a were#int("*L")wolf?#int("H%", line: false)
/// ```
#let int(
  label,
  line: true,
  height: 1.5em,
  lift: 0.4em,
) = {
  box(width: 0pt, height: 0pt, {
    // Label: bottom edge sits at (lift + height) above the text baseline
    place(
      bottom + center,
      dy: -(lift + height),
      context text(font: phonokit-font.get(), label),
    )
    // Vertical stem: spans from (lift) to (lift + height) above the text baseline
    // Uses rect to avoid shadowing Typst's built-in line() with the `line` parameter
    if line {
      place(
        bottom + center,
        dy: -lift,
        rect(width: 0.05em, height: height, fill: black, stroke: none),
      )
    }
  })
}
