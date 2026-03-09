#import "_config.typ": phonokit-font

/// Place a ToBI label above the current inline text position
///
/// Designed to be placed inline immediately after the syllable or word being annotated.
/// The label floats above the text at the insertion point, optionally connected by
/// a vertical stem. Supports the full ToBI label inventory (Beckman & Hirschberg).
///
/// Always pass labels as *strings* (e.g. `"H*"`), not bare content (`[H*]`), since
/// characters like `*` and `_` have special meaning in Typst markup. Use ASCII
/// hyphens for phrase accents (e.g. `"L-"`, `"L-H%"`); en/em dashes are
/// automatically normalized to hyphens.
///
/// ToBI label inventory:
/// - Pitch accents: `"H*"`, `"L*"`, `"L*+H"`, `"L+H*"`, `"H+!H*"`
/// - Phrase accents: `"L-"`, `"H-"`, `"!H-"`
/// - Boundary tones: `"L%"`, `"H%"`, `"!H%"`
/// - Initial boundary: `"%H"`, `"%r"`
/// - Combined (level 4): `"L-L%"`, `"L-H%"`, `"H-H%"`, `"H-L%"`, `"!H-L%"`, `"!H-H%"`
/// - Underspecified: `"*"`, `"-"`, `"%"`
/// - Uncertainty: `"*?"`, `"-?"`, `"%?"`, `"X*?"`
/// - Alignment: `"<"` (early F0), `">"` (late F0)
///
/// Arguments:
/// - label (string): ToBI label
/// - line (boolean): draw a vertical stem connecting label to text (default: true)
/// - height (length): distance from text baseline to the bottom of the label (default: 1.8em)
/// - lift (length): gap between text baseline and stem bottom (default: 0.6em)
/// - gap (length): gap between stem top and label bottom (default: 0.15em)
/// - en-dash (boolean): render phrase-accent hyphens as en dashes (default: false)
///
/// Example:
/// ```
/// #import "@preview/phonokit:0.4.5": *
/// You're a were#int("L+H*")wolf?#int("L-L%", line: false)
/// ```
#let int(
  label,
  line: true,
  height: 2em,
  lift: 0.8em,
  gap: 0.22em,
  en-dash: true,
) = context {
  // Normalize all dash variants to ASCII hyphen, then output in the desired
  // form. U+2011 (non-breaking hyphen, class GL) never breaks. For en-dash
  // rendering, U+2060 (word joiner, class WJ) prepended to U+2013 suppresses
  // any break opportunity around the en dash.
  let safe = if type(label) == str {
    let normalized = label
      .replace("\u{2011}", "-") // non-breaking hyphen → ASCII
      .replace("\u{2013}", "-") // en dash → ASCII
      .replace("\u{2014}", "-") // em dash → ASCII
    if en-dash {
      normalized.replace("-", "\u{2060}\u{2013}\u{2060}") // WJ + en dash + WJ
    } else {
      normalized.replace("-", "\u{2011}") // non-breaking hyphen (default)
    }
  } else { label }
  // Measure the raw text first, then wrap in a box with an explicit width so
  // that Typst cannot re-wrap the label to fit the parent's 0pt available width.
  let lbl-text = text(font: phonokit-font.get(), size: 0.8em, safe)
  let lbl-w = measure(lbl-text).width
  let lbl = box(width: lbl-w, lbl-text)
  // baseline: 0pt places the box bottom at the text baseline,
  // so the box extends upward to reserve space for the annotation.
  // stack(dir: btt) builds from the baseline upward:
  //   lift gap → stem → gap → label (centered via move)
  box(width: 0pt, baseline: 0pt, stack(
    dir: btt,
    v(lift),
    if line {
      rect(width: 0.05em, height: height - lift - gap, fill: black, stroke: none)
    } else {
      v(height - lift - gap)
    },
    v(gap),
    move(dx: -lbl-w / 2, lbl),
  ))
}
