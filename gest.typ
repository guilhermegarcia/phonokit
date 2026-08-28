// Articulatory gestural scores inspired by Browman & Goldstein (1989)
// Part of phonokit package

#import "@preview/cetz:0.5.2"
#import "_config.typ": phonokit-font
#import "ipa.typ": ipa-to-unicode

#let _gest-is-number(value) = type(value) == int or type(value) == float

#let _gest-is-point(value) = {
  type(value) == array and value.len() == 2 and _gest-is-number(value.at(0)) and _gest-is-number(value.at(1))
}

#let _gest-is-point-list(value) = {
  if type(value) != array or value.len() < 2 {
    false
  } else {
    let valid = true
    for point in value {
      if not _gest-is-point(point) { valid = false }
    }
    valid
  }
}

#let _gest-normalize-motions(motions, tiers) = {
  assert(type(motions) == dictionary, message: "motions must be a dictionary keyed by tier")
  let resolved = ()

  for (raw-tier, value) in motions {
    let tier = lower(str(raw-tier))
    assert(tier in tiers, message: "motion tier must be one of vel, tb, tt, lips, or glo")

    // A point list is one manual motion; any other array is a list of motions.
    let specs = if type(value) == str or type(value) == dictionary or _gest-is-point-list(value) {
      (value,)
    } else {
      assert(type(value) == array and value.len() > 0, message: tier + " motions must not be empty")
      value
    }

    for spec in specs {
      if type(spec) == str {
        assert(lower(spec) == "normal", message: "the only string motion shorthand is `normal`")
        resolved.push((tier: tier, kind: "normal", gesture: 0, position: auto))
      } else if _gest-is-point-list(spec) {
        resolved.push((tier: tier, kind: "manual", points: spec))
      } else {
        assert(type(spec) == dictionary, message: tier + " motion specs must be `normal`, point arrays, or dictionaries")
        let inferred-kind = if "points" in spec { "manual" } else { "normal" }
        let kind = lower(str(spec.at("kind", default: inferred-kind)))
        assert(kind == "normal" or kind == "manual", message: "motion kind must be `normal` or `manual`")

        if kind == "manual" {
          assert("points" in spec, message: "manual motions must specify points")
          resolved.push((tier: tier, kind: "manual", points: spec.at("points")))
        } else {
          resolved.push((
            tier: tier,
            kind: "normal",
            gesture: spec.at("gesture", default: 0),
            position: spec.at("position", default: auto),
          ))
        }
      }
    }
  }
  resolved
}

#let _gest-clamp(value, minimum: 0.0, maximum: 1.0) = {
  calc.max(minimum, calc.min(maximum, value))
}

#let _gest-tick-step(duration) = {
  let rough = duration / 4
  if rough <= 1 { 1 }
  else if rough <= 2 { 2 }
  else if rough <= 5 { 5 }
  else if rough <= 10 { 10 }
  else if rough <= 20 { 20 }
  else if rough <= 25 { 25 }
  else if rough <= 50 { 50 }
  else if rough <= 100 { 100 }
  else if rough <= 200 { 200 }
  else if rough <= 250 { 250 }
  else if rough <= 500 { 500 }
  else if rough <= 1000 { 1000 }
  else { calc.ceil(rough / 1000) * 1000 }
}

#let _gest-number-label(value) = {
  if value == calc.round(value) { str(int(value)) } else { str(value) }
}

#let _gest-parse-interval(spec, tier) = {
  assert(
    type(spec) == array and (spec.len() == 2 or spec.len() == 3),
    message: tier + " gesture entries must be `(start, end)` or `(label, start, end)`",
  )
  let labelled = spec.len() == 3
  let start = spec.at(if labelled { 1 } else { 0 })
  let end = spec.at(if labelled { 2 } else { 1 })
  assert(
    _gest-is-number(start) and _gest-is-number(end),
    message: tier + " gesture coordinates must be numbers",
  )
  let start = float(start)
  let end = float(end)
  assert(
    start >= 0 and end <= 1 and start < end,
    message: tier + " gesture coordinates must satisfy `0 <= start < end <= 1`",
  )
  (
    label: if labelled { spec.at(0) } else { none },
    start: start,
    end: end,
  )
}

#let _gest-parse-tier(entries, tier) = {
  assert(type(entries) == array, message: tier + " must be an array of gesture entries")
  entries.map(entry => _gest-parse-interval(entry, tier))
}

/// Draw an articulatory gestural score.
///
/// The score uses five articulatory tiers (VEL, TB, TT, LIPS, and GLO),
/// normalized horizontal positions, a millisecond time axis, and an IPA-aware
/// label tier. Optional motions can be Gaussian curves associated with a
/// gesture or smooth manual curves through normalized points.
#let gest(
  duration: none,
  label: none,
  vel: (),
  tb: (),
  tt: (),
  lips: (),
  glo: (),
  motions: (:),
  tiers: auto,
  grid: false,
  border: false,
  axis: auto,
  motion-color: rgb("#2474a6"),
  scale: 1.0,
) = context {
  assert(_gest-is-number(duration), message: "duration must be a number of milliseconds")
  assert(duration > 0, message: "duration must be greater than zero")
  assert(type(label) == array, message: "label must be an array")
  assert(label.len() > 0, message: "label cannot be empty")
  assert(type(grid) == bool, message: "grid must be true or false")
  assert(type(border) == bool, message: "border must be true or false")
  assert(axis == auto or type(axis) == bool, message: "axis must be auto, true, or false")
  assert(type(motion-color) == color, message: "motion-color must be a color")
  assert(_gest-is-number(scale) and scale > 0, message: "scale must be greater than zero")

  let tier-data = (
    vel: _gest-parse-tier(vel, "vel"),
    tb: _gest-parse-tier(tb, "tb"),
    tt: _gest-parse-tier(tt, "tt"),
    lips: _gest-parse-tier(lips, "lips"),
    glo: _gest-parse-tier(glo, "glo"),
  )
  let all-tier-order = ("vel", "tb", "tt", "lips", "glo")
  let tier-labels = (vel: "VEL", tb: "TB", tt: "TT", lips: "LIPS", glo: "GLO")
  let resolved-motions = _gest-normalize-motions(motions, all-tier-order)
  let motion-tiers = resolved-motions.map(motion => motion.at("tier"))
  let active-tiers = all-tier-order.filter(tier => tier-data.at(tier).len() > 0 or tier in motion-tiers)
  let tier-order = if tiers == auto {
    active-tiers
  } else {
    assert(type(tiers) == array, message: "tiers must be auto or an array of tier names")
    let requested = ()
    for raw-tier in tiers {
      assert(type(raw-tier) == str, message: "tier names must be strings")
      let tier = lower(raw-tier)
      assert(tier in all-tier-order, message: "tiers may contain only vel, tb, tt, lips, or glo")
      assert(not tier in requested, message: "tiers cannot contain duplicates")
      requested.push(tier)
    }
    for tier in active-tiers {
      assert(tier in requested, message: "tiers must include every tier that contains a gesture or motion")
    }
    requested
  }
  assert(tier-order.len() > 0, message: "gest requires at least one visible tier")

  let scale-factor = float(scale)
  let duration-ms = float(duration)
  let tick-step = _gest-tick-step(duration-ms)
  let tick-size = 6.5pt * scale-factor
  let axis-visible = if axis == auto { resolved-motions.len() > 0 } else { axis }
  let tick-values = ()
  let next-tick = 0.0
  while next-tick <= duration-ms {
    tick-values.push(next-tick)
    next-tick += tick-step
  }
  if calc.abs(tick-values.last() - duration-ms) > 0.000001 {
    tick-values.push(duration-ms)
  }
  let tick-label-content = value => text(
    font: phonokit-font.get(),
    size: tick-size,
    _gest-number-label(value),
  )
  let max-tick-label-width = calc.max(..tick-values.map(value => (
    measure(tick-label-content(value)).width / 1cm / scale-factor
  )))

  // Bottom labels establish the normal width. Unusually wide time labels can
  // expand it so neighboring ticks never collide.
  let score-labels = label
  let cell-width = 1.55
  let label-driven-width = score-labels.len() * cell-width
  // Endpoint labels are aligned inward, so the first and last intervals must
  // accommodate one full endpoint label plus half of its neighbor.
  let tick-driven-width = if axis-visible {
    (tick-values.len() - 1) * (max-tick-label-width * 1.5 + 0.24)
  } else {
    0
  }
  let score-width = calc.max(label-driven-width, tick-driven-width)
  let tier-spacing = 1.13
  let tier-height = 0.68
  let first-tier-y = (tier-order.len() - 1) * tier-spacing
  let axis-y = -0.62
  let axis-title-y = -1.12
  let label-y = if axis-visible { -1.66 } else { -0.91 }
  let frame-bottom-y = if axis-visible { axis-title-y - 0.18 } else { -tier-height / 2 - 0.18 }
  let box-stroke = (paint: luma(55), thickness: 0.7pt * scale-factor)
  let motion-stroke = (
    paint: motion-color,
    thickness: 1.05pt * scale-factor,
    cap: "round",
    join: "round",
  )
  let guide-stroke = (paint: luma(215), thickness: 0.45pt * scale-factor)
  let axis-stroke = (paint: luma(65), thickness: 0.65pt * scale-factor)
  let label-size = 8pt * scale-factor
  let gesture-size = 7pt * scale-factor
  let bottom-label-size = 9pt * scale-factor
  let guides-visible = grid
  let border-visible = border
  let x-pos = value => value * score-width
  let tier-y = tier => first-tier-y - tier-order.position(item => item == tier) * tier-spacing
  let tier-bottom = tier => tier-y(tier) - tier-height / 2
  let tier-top = tier => tier-y(tier) + tier-height / 2
  let curve-point = (tier, point) => (
    x-pos(point.at(0)),
    tier-bottom(tier) + point.at(1) * tier-height,
  )

  let rendered-bottom-label = body => {
    let rendered = if type(body) == str { ipa-to-unicode(body) } else { body }
    text(font: phonokit-font.get(), size: bottom-label-size, rendered)
  }
  let bottom-bracket = body => text(
    font: phonokit-font.get(),
    size: bottom-label-size,
    body,
  )
  let rendered-gesture = (body, width) => {
    let outer-width = width * scale-factor * 1cm
    let outer-height = tier-height * scale-factor * 1cm
    let inner-width = calc.max(0.04cm, outer-width - 0.12cm * scale-factor)
    let inner-height = calc.max(0.04cm, outer-height - 0.10cm * scale-factor)
    let minimum-size = 4pt * scale-factor
    let size = gesture-size
    let make-label = size => block(
      width: inner-width,
      align(center, {
        set par(leading: 0.28em)
        set text(hyphenate: true)
        text(font: phonokit-font.get(), size: size, body)
      }),
    )
    let fitted = make-label(size)
    while measure(fitted).height > inner-height and size > minimum-size {
      size = calc.max(minimum-size, size - 0.25pt * scale-factor)
      fitted = make-label(size)
    }
    box(
      width: outer-width,
      height: outer-height,
      clip: true,
      align(center + horizon, fitted),
    )
  }

  box(inset: 0.75em, baseline: 45%, cetz.canvas(length: scale-factor * 1cm, {
    import cetz.draw: *

    // Light tier guides make timing relationships visible.
    for tier in tier-order {
      if guides-visible {
        line((0, tier-y(tier)), (score-width, tier-y(tier)), stroke: guide-stroke)
      }
      content(
        (-0.35, tier-y(tier)),
        text(font: phonokit-font.get(), size: label-size, weight: "bold", tier-labels.at(tier)),
        anchor: "east",
      )
    }

    // Activation intervals.
    for tier in tier-order {
      for gesture in tier-data.at(tier) {
        let x1 = x-pos(gesture.start)
        let x2 = x-pos(gesture.end)
        rect(
          (x1, tier-bottom(tier)),
          (x2, tier-top(tier)),
          fill: white,
          stroke: box-stroke,
        )
      }
    }

    // Optional model motions, rendered above activation intervals.
    for motion in resolved-motions {
      let tier = motion.at("tier")
      let kind = motion.at("kind")

      if kind == "normal" {
        let interval = motion.at("position", default: auto)
        if interval == auto {
          let gesture-index = motion.at("gesture", default: 0)
          assert(type(gesture-index) == int, message: "normal motion gesture index must be an integer")
          let gestures = tier-data.at(tier)
          assert(
            gesture-index >= 0 and gesture-index < gestures.len(),
            message: "normal motion gesture index does not exist on tier " + tier,
          )
          let gesture = gestures.at(gesture-index)
          interval = (gesture.start, gesture.end)
        } else {
          assert(
            type(interval) == array and interval.len() == 2
              and _gest-is-number(interval.at(0)) and _gest-is-number(interval.at(1)),
            message: "normal motion position must be `(start, end)`",
          )
          interval = (float(interval.at(0)), float(interval.at(1)))
          assert(
            interval.at(0) >= 0 and interval.at(1) <= 1 and interval.at(0) < interval.at(1),
            message: "normal motion position must satisfy `0 <= start < end <= 1`",
          )
        }

        let start = interval.at(0)
        let end = interval.at(1)
        let center = (start + end) / 2
        let sigma = (end - start) / 6
        let samples = ()
        for i in range(65) {
          let progress = i / 64
          let x = start + progress * (end - start)
          let z = (x - center) / sigma
          let y = calc.exp(-0.5 * z * z)
          samples.push(curve-point(tier, (x, y)))
        }
        line(..samples, stroke: motion-stroke)
      } else {
        assert("points" in motion, message: "manual motions must specify points")
        let points = motion.at("points")
        assert(type(points) == array and points.len() >= 2, message: "manual motion points must contain at least two points")
        let parsed = ()
        for (index, point) in points.enumerate() {
          assert(
            type(point) == array and point.len() == 2
              and _gest-is-number(point.at(0)) and _gest-is-number(point.at(1)),
            message: "manual motion points must be `(x, y)` number pairs",
          )
          let x = float(point.at(0))
          let y = float(point.at(1))
          assert(x >= 0 and x <= 1 and y >= 0 and y <= 1, message: "manual motion coordinates must be between 0 and 1")
          if index > 0 {
            assert(x > parsed.last().at(0), message: "manual motion x coordinates must be strictly increasing")
          }
          parsed.push((x, y))
        }

        // Catmull-Rom-to-Bezier conversion. Control points are clamped to
        // each segment and tier so smoothing never overshoots the input range.
        for index in range(parsed.len() - 1) {
          let p0 = parsed.at(calc.max(0, index - 1))
          let p1 = parsed.at(index)
          let p2 = parsed.at(index + 1)
          let p3 = parsed.at(calc.min(parsed.len() - 1, index + 2))
          let c1 = (
            _gest-clamp(p1.at(0) + (p2.at(0) - p0.at(0)) / 6, minimum: p1.at(0), maximum: p2.at(0)),
            _gest-clamp(p1.at(1) + (p2.at(1) - p0.at(1)) / 6),
          )
          let c2 = (
            _gest-clamp(p2.at(0) - (p3.at(0) - p1.at(0)) / 6, minimum: p1.at(0), maximum: p2.at(0)),
            _gest-clamp(p2.at(1) - (p3.at(1) - p1.at(1)) / 6),
          )
          bezier(
            curve-point(tier, p1),
            curve-point(tier, p2),
            curve-point(tier, c1),
            curve-point(tier, c2),
            stroke: motion-stroke,
          )
        }
      }
    }

    // Labels remain legible by sitting above both boxes and motions.
    for tier in tier-order {
      for gesture in tier-data.at(tier) {
        if gesture.label != none {
          content(
            (x-pos((gesture.start + gesture.end) / 2), tier-y(tier)),
            rendered-gesture(gesture.label, x-pos(gesture.end) - x-pos(gesture.start)),
            anchor: "center",
          )
        }
      }
    }

    // Millisecond time axis: automatic with motions, or manually overridden.
    if axis-visible {
      line((0, axis-y), (score-width, axis-y), stroke: axis-stroke)
      for (index, tick) in tick-values.enumerate() {
        let x = tick / duration-ms * score-width
        line((x, axis-y), (x, axis-y - 0.10), stroke: axis-stroke)
        let tick-anchor = if index == 0 {
          "north-west"
        } else if index == tick-values.len() - 1 {
          "north-east"
        } else {
          "north"
        }
        content(
          (x, axis-y - 0.16),
          tick-label-content(tick),
          anchor: tick-anchor,
        )
      }
      content(
        (score-width / 2, axis-title-y),
        text(font: phonokit-font.get(), size: tick-size, [Time (ms)]),
        anchor: "center",
      )
    }

    // IPA-aware, equal-width bottom label tier.
    for (index, item) in score-labels.enumerate() {
      content(
        ((index + 0.5) * score-width / score-labels.len(), label-y),
        rendered-bottom-label(item),
        anchor: "center",
      )
    }
    content((-0.04, label-y), bottom-bracket("["), anchor: "east")
    content((score-width + 0.04, label-y), bottom-bracket("]"), anchor: "west")

    // Keep the optional Figure 3-style frame above every interior layer.
    if border-visible {
      rect(
        (-0.22, frame-bottom-y),
        (score-width + 0.22, tier-top(tier-order.first()) + 0.18),
        fill: none,
        radius: 0.10,
        stroke: box-stroke,
      )
    }
  }))
}
