#import "@preview/cetz:0.4.2": canvas, draw
#import "ipa.typ": ipa-to-unicode
#import "_config.typ": phonokit-font

// Vowel data with relative positions (0-1 scale)
// frontness: 0 = front, 0.5 = central, 1 = back
// height: 1 = close, 0.67 = close-mid, 0.33 = open-mid, 0 = open
// rounded: affects horizontal positioning within minimal pairs
#let vowel-data = (
  "i": (frontness: 0.05, height: 1.00, rounded: false),
  "y": (frontness: 0.05, height: 1.00, rounded: true),
  "ɨ": (frontness: 0.50, height: 1.00, rounded: false),
  "ʉ": (frontness: 0.50, height: 1.00, rounded: true),
  "ɯ": (frontness: 0.95, height: 1.00, rounded: false),
  "u": (frontness: 0.95, height: 1.00, rounded: true),
  "ɪ": (frontness: 0.15, height: 0.85, rounded: false),
  "ʏ": (frontness: 0.25, height: 0.85, rounded: true),
  "ʊ": (frontness: 0.85, height: 0.85, rounded: true),
  "e": (frontness: 0.05, height: 0.67, rounded: false),
  "ø": (frontness: 0.05, height: 0.67, rounded: true),
  "ɘ": (frontness: 0.50, height: 0.67, rounded: false),
  "ɵ": (frontness: 0.50, height: 0.67, rounded: true),
  "ɤ": (frontness: 0.95, height: 0.67, rounded: false),
  "o": (frontness: 0.95, height: 0.67, rounded: true),
  "ə": (frontness: 0.585, height: 0.51, rounded: false),
  "ɛ": (frontness: 0.05, height: 0.34, rounded: false),
  "œ": (frontness: 0.05, height: 0.34, rounded: true),
  "ɜ": (frontness: 0.50, height: 0.34, rounded: false),
  "ɞ": (frontness: 0.50, height: 0.34, rounded: true),
  "ʌ": (frontness: 0.95, height: 0.34, rounded: false),
  "ɔ": (frontness: 0.95, height: 0.34, rounded: true),
  "æ": (frontness: 0.05, height: 0.15, rounded: false),
  "ɐ": (frontness: 0.585, height: 0.18, rounded: false),
  "a": (frontness: 0.05, height: 0.00, rounded: false),
  "ɶ": (frontness: 0.05, height: 0.00, rounded: true),
  "ɑ": (frontness: 0.95, height: 0.00, rounded: false),
  "ɒ": (frontness: 0.95, height: 0.00, rounded: true),
)

// Calculate actual position from relative coordinates
#let get-vowel-position(vowel-info, trapezoid, width, height, offset) = {
  let front = vowel-info.frontness
  let h = vowel-info.height

  // Calculate y coordinate
  let y = -height / 2 + (h * height)

  // Interpolate x based on trapezoid shape at this height
  let t = 1 - h // interpolation factor (0 at top, 1 at bottom)
  let left-x = trapezoid.at(0).at(0) * (1 - t) + trapezoid.at(3).at(0) * t
  let right-x = trapezoid.at(1).at(0) * (1 - t) + trapezoid.at(2).at(0) * t

  let x = 0

  // Front vowels (frontness < 0.4)
  if front < 0.4 {
    // Extreme front (< 0.15): tense vowels like i, e
    if front < 0.15 {
      if vowel-info.rounded {
        // Front rounded: inside (right of left edge)
        x = left-x + offset
      } else {
        // Front unrounded: outside (left of left edge)
        x = left-x - offset
      }
    } // Near-front (0.15-0.4): lax vowels like ɪ, ɛ
    // Always positioned inside the trapezoid
    else {
      x = left-x + (front * (right-x - left-x))
    }
  } // Back vowels (frontness > 0.6)
  else if front > 0.6 {
    // Extreme back (> 0.85): tense vowels like u, o
    if front > 0.85 {
      if vowel-info.rounded {
        // Back rounded: outside (right of right edge)
        x = right-x + offset
      } else {
        // Back unrounded: inside (left of right edge)
        x = right-x - offset
      }
    } // Near-back (0.6-0.85): lax vowels like ʊ
    // Always positioned inside the trapezoid
    else {
      x = left-x + (front * (right-x - left-x))
    }
  } // Central vowels
  else {
    // Calculate base central position
    let center-x = left-x + (front * (right-x - left-x))

    // Apply full offset for rounded/unrounded pairs (same as front/back)
    if vowel-info.rounded {
      x = center-x + offset // Rounded to the right
    } else {
      x = center-x - offset // Unrounded to the left
    }
  }

  (x, y)
}

// Language vowel inventories
#let language-vowels = (
  "spanish": "aeoiu",
  "portuguese": "iɔeaouɛ",
  "italian": "iɔeaouɛ",
  "english": "iɪaeɛæɑɔoʊuʌə",
  "french": "iœɑɔøeaouɛyə",
  "german": "iyʊuɪʏeøoɔɐaɛœ",
  "japanese": "ieaou",
  "russian": "iɨueoa",
  "arabic": "aiu",
  "all": "iyɨʉɯuɪʏʊeøɘɵɤoəɛœɜɞʌɔæɐaɶɑɒ",
  // Add more languages here or adjust existing inventories
)

// Main vowels function
#let vowels(
  vowel-string, // Positional parameter (no default to allow positional args)
  lang: none,
  width: 8,
  height: 6,
  rows: 3, // Only 2 internal horizontal lines
  cols: 2, // Only 1 vertical line inside trapezoid
  scale: 0.7, // Scale factor for entire chart
  arrows: (), // List of (from-tipa-str, to-tipa-str) tuples
  arrow-color: black, // Color for arrow lines and heads
  arrow-style: "solid", // "solid" or "dashed"
  curved: false, // Curve arrows with a quadratic bezier arc
  shift: (), // List of (tipa-str, x-offset, y-offset) tuples
  shift-color: gray, // Color for shifted vowel symbols
  shift-size: none, // Font size for shifted vowels; none = same as regular
  highlight: (), // List of tipa strings whose background circle is highlighted
  highlight-color: luma(220), // Circle color for highlighted vowels (default: light gray)
) = {
  // Determine which vowels to plot
  let vowels-to-plot = ""
  let error-msg = none

  // Check if vowel-string is actually a language name
  if vowel-string in language-vowels {
    // It's a language name - use language vowels
    vowels-to-plot = language-vowels.at(vowel-string)
  } else if lang != none {
    // Explicit lang parameter provided
    if lang in language-vowels {
      vowels-to-plot = language-vowels.at(lang)
    } else {
      // Language not available - prepare error message
      let available = language-vowels.keys().join(", ")
      error-msg = [*Error:* Language "#lang" not available. \ Available languages: #available]
    }
  } else if vowel-string != "" {
    // Use as manual vowel specification - convert IPA notation to Unicode
    // Note: Diacritics and non-vowel symbols will be ignored during plotting
    vowels-to-plot = ipa-to-unicode(vowel-string)
  } else {
    // Nothing specified
    error-msg = [*Error:* Either provide vowel string or language name]
  }

  // If there's an error, display it and return
  if error-msg != none {
    return error-msg
  }

  // Calculate scaled dimensions
  let scaled-width = width * scale
  let scaled-height = height * scale
  let scaled-offset = 0.55 * scale
  let scaled-circle-radius = 0.35 * scale
  let scaled-bullet-radius = 0.09 * scale
  let scaled-font-size = 22 * scale
  let scaled-line-thickness = 0.85 * scale
  let scaled-arrow-mark = 1.5 * scale
  let resolved-shift-size = if shift-size != none { shift-size * scale } else { scaled-font-size * 1pt }
  // Split highlight into regular-vowel highlights (strings) and shifted-vowel
  // highlights (arrays in the same (tipa-str, x, y) format as shift:)
  let highlight-set = highlight.filter(h => type(h) == str).map(ipa-to-unicode)
  let highlight-shifts = highlight.filter(h => type(h) != str)
    .map(h => (ipa-to-unicode(h.at(0)), h.at(1), h.at(2)))

  canvas({
    import draw: *

    // Define the trapezoidal quadrilateral using scaled dimensions
    let trapezoid = (
      (-scaled-width / 2, scaled-height / 2.),
      (scaled-width / 2., scaled-height / 2),
      (scaled-width / 2., -scaled-height / 2),
      (-scaled-width / 10, -scaled-height / 2),
    )

    // Draw horizontal grid lines
    for i in range(1, rows) {
      let t = i / rows
      let left-x = trapezoid.at(0).at(0) * (1 - t) + trapezoid.at(3).at(0) * t
      let right-x = trapezoid.at(1).at(0) * (1 - t) + trapezoid.at(2).at(0) * t
      let y = scaled-height / 2 - (scaled-height * t)

      line((left-x, y), (right-x, y), stroke: (paint: gray.lighten(30%), thickness: scaled-line-thickness * 1pt))
    }

    // Draw vertical grid lines
    for i in range(1, cols) {
      let t = i / cols
      let top-x = trapezoid.at(0).at(0) * (1 - t) + trapezoid.at(1).at(0) * t
      let bottom-x = trapezoid.at(3).at(0) * (1 - t) + trapezoid.at(2).at(0) * t

      line((top-x, scaled-height / 2), (bottom-x, -scaled-height / 2), stroke: (
        paint: gray.lighten(30%),
        thickness: scaled-line-thickness * 1pt,
      ))
    }

    // Draw the outline
    line(..trapezoid, close: true, stroke: (paint: gray.lighten(30%), thickness: scaled-line-thickness * 1pt))

    // Resolve an arrow endpoint to a canvas position.
    // endpoint is either a tipa string (canonical vowel position) or a
    // (tipa-str, x-offset, y-offset) array (shifted position, same format as shift:).
    // Returns (found, position) where found is false if the vowel is unknown.
    let pos-of(endpoint) = {
      let is-str = type(endpoint) == str
      let v = ipa-to-unicode(if is-str { endpoint } else { endpoint.at(0) })
      let x-off = if is-str { 0 } else { endpoint.at(1) }
      let y-off = if is-str { 0 } else { endpoint.at(2) }
      if v in vowel-data {
        let base = get-vowel-position(vowel-data.at(v), trapezoid, scaled-width, scaled-height, scaled-offset)
        (true, (base.at(0) + x-off, base.at(1) + y-off))
      } else {
        (false, (0, 0))
      }
    }

    // Collect vowel positions
    let vowel-positions = ()
    for vowel in vowels-to-plot.clusters() {
      if vowel in vowel-data {
        let vowel-info = vowel-data.at(vowel)
        let pos = get-vowel-position(vowel-info, trapezoid, scaled-width, scaled-height, scaled-offset)
        vowel-positions.push((vowel: vowel, info: vowel-info, pos: pos))
      }
    }

    // Draw arrows between vowel positions (e.g. diphthongs)
    for arrow in arrows {
      let fr = pos-of(arrow.at(0))
      let tr = pos-of(arrow.at(1))
      if fr.at(0) and tr.at(0) {
        let from-pos = fr.at(1)
        let to-pos = tr.at(1)
        let dx = to-pos.at(0) - from-pos.at(0)
        let dy = to-pos.at(1) - from-pos.at(1)
        let dist = calc.sqrt(dx * dx + dy * dy)

        // Bezier control point: 90° CCW offset at 30% of chord, anchored on the
        // midpoint of the original (unadjusted) endpoints so the curve shape is
        // independent of the circle-edge adjustment below.
        let mid-x = (from-pos.at(0) + to-pos.at(0)) / 2
        let mid-y = (from-pos.at(1) + to-pos.at(1)) / 2
        let ctrl = (mid-x + (-dy / dist) * dist * 0.3, mid-y + (dx / dist) * dist * 0.3)

        // Tangent unit vector at the destination:
        //   straight → chord direction
        //   curved   → ctrl→to-pos direction (true tangent of the bezier at t=1)
        // This must be computed before adjusted-to so that the endpoint is backed
        // off along the actual arrival angle of the curve, not the chord.
        let tangent = if curved {
          let ex = to-pos.at(0) - ctrl.at(0)
          let ey = to-pos.at(1) - ctrl.at(1)
          let ed = calc.sqrt(ex * ex + ey * ey)
          (ex / ed, ey / ed)
        } else {
          (dx / dist, dy / dist)
        }

        // Pull the endpoint back to the circle edge along the arrival tangent
        let adjusted-to = (
          to-pos.at(0) - tangent.at(0) * scaled-circle-radius,
          to-pos.at(1) - tangent.at(1) * scaled-circle-radius,
        )

        let shaft-stroke = (paint: arrow-color, thickness: scaled-line-thickness * 1.5pt,
          dash: if arrow-style == "dashed" { "dashed" } else { none })
        let head-stroke = (paint: arrow-color, thickness: scaled-line-thickness * 1.5pt)
        let mark-style = (end: ">", fill: arrow-color, scale: scaled-arrow-mark)

        if arrow-style == "dashed" {
          // Draw dashed shaft without a mark
          if curved {
            bezier(from-pos, adjusted-to, ctrl, stroke: shaft-stroke)
          } else {
            line(from-pos, adjusted-to, stroke: shaft-stroke)
          }
          // Draw a near-zero-length solid segment at the endpoint so the mark
          // is rendered solid and correctly oriented, independent of the dash pattern
          let tiny = 0.01
          let head-anchor = (
            adjusted-to.at(0) - tangent.at(0) * tiny,
            adjusted-to.at(1) - tangent.at(1) * tiny,
          )
          line(head-anchor, adjusted-to, stroke: head-stroke, mark: mark-style)
        } else {
          // Solid: shaft and arrowhead in one draw call
          if curved {
            bezier(from-pos, adjusted-to, ctrl, stroke: shaft-stroke, mark: mark-style)
          } else {
            line(from-pos, adjusted-to, stroke: shaft-stroke, mark: mark-style)
          }
        }
      }
    }

    // Draw bullets between minimal pairs (same frontness/height, different rounding)
    for i in range(vowel-positions.len()) {
      for j in range(i + 1, vowel-positions.len()) {
        let v1 = vowel-positions.at(i)
        let v2 = vowel-positions.at(j)

        // Check if they form a minimal pair
        let same-front = v1.info.frontness == v2.info.frontness
        let same-height = v1.info.height == v2.info.height
        let diff-round = v1.info.rounded != v2.info.rounded

        if same-front and same-height and diff-round {
          // Draw bullet at midpoint between vowels
          let mid-x = (v1.pos.at(0) + v2.pos.at(0)) / 2
          let mid-y = (v1.pos.at(1) + v2.pos.at(1)) / 2
          circle((mid-x, mid-y), radius: scaled-bullet-radius, fill: black)
        }
      }
    }

    // Plot vowels with background circles (white, or highlight color if highlighted)
    for vp in vowel-positions {
      let circle-fill = if vp.vowel in highlight-set { highlight-color } else { white }
      circle(vp.pos, radius: scaled-circle-radius, fill: circle-fill, stroke: none)
      content(vp.pos, context text(size: scaled-font-size * 1pt, font: phonokit-font.get(), top-edge: "x-height", bottom-edge: "baseline", vp.vowel))
    }

    // Draw shifted vowels (on top of regular vowels)
    for s in shift {
      let vowel = ipa-to-unicode(s.at(0))
      let x-off = s.at(1)
      let y-off = s.at(2)
      if vowel in vowel-data {
        let base-pos = get-vowel-position(vowel-data.at(vowel), trapezoid, scaled-width, scaled-height, scaled-offset)
        let shifted-pos = (base-pos.at(0) + x-off, base-pos.at(1) + y-off)
        let shift-fill = if highlight-shifts.any(h => h.at(0) == vowel and h.at(1) == x-off and h.at(2) == y-off) { highlight-color } else { white }
        circle(shifted-pos, radius: scaled-circle-radius, fill: shift-fill, stroke: none)
        content(shifted-pos, context text(size: resolved-shift-size, font: phonokit-font.get(), fill: shift-color, top-edge: "x-height", bottom-edge: "baseline", vowel))
      }
    }
  })
}
