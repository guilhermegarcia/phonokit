#import "lib.typ": *

// #set page(width: auto, height: auto, margin: 1.5cm)
#set text(size: 10pt)

= `gest()` test file

The horizontal coordinates below are proportions from `0` to `1`. The `duration` argument maps that range onto milliseconds. Each string in `label` occupies one equal-width cell and uses the same notation as `ipa()`.

== Activation intervals only

#gest(
  duration: 400,
  label: ("p \\h", "A", "m"),
  vel: (([wide], 0.72, 0.96),),
  tb: (([narrow\ pharyngeal], 0.20, 0.72),),
  lips: (
    ([clo\ labial], 0.04, 0.23),
    ([clo\ labial], 0.72, 0.96),
  ),
  glo: (([wide], 0.06, 0.34),),
  border: true,
)


== Activation intervals with motions

Here's where keeping things minimal becomes tricky. My initial idea is this: coordinates tied to each argument, but specified separately inside teh function.

#gest(
  duration: 400,
  label: ("p", "a", "m"),
  vel: (([wide], 0.72, 0.96),),
  tb: (([narrow\ pharyngeal], 0.20, 0.72),),
  lips: (
    ([clo\ labial], 0.04, 0.23),
    ([clo\ labial], 0.72, 0.96),
  ),
  glo: (([wide], 0.06, 0.34),),
  motions: (
    vel: ((0, 0.18), (0.68, 0.18), (0.82, 0.88), (1, 0.88)),
    tb: ((0, 0.72), (0.30, 0.88), (0.58, 0.72), (0.82, 0.20), (1, 0.28)),
    lips: ((0, 0.82), (0.13, 0.12), (0.36, 0.88), (0.72, 0.82), (0.84, 0.12), (1, 0.82)),
    glo: "normal",
  ),
  border: true,
)

== Small API checks

Some `tipa` conversion, an unlabeled interval, the TT tier, automatic tier filtering, a non-round duration, an explicit normal-motion position, scaling, and a bordered score without background grid lines.

#gest(
  duration: 75,
  label: ("tS", "a:"),
  vel: ((0.60, 0.80),),
  tt: (([clo alveolar], 0.28, 0.43),),
  motions: (
    glo: (position: (0.20, 0.50)),
  ),
  grid: false,
  border: true,
  motion-color: rgb("#b03a5b"),
  scale: 0.8,
)

== Extreme duration layout

The plot expands when necessary to keep unusually wide time labels separate and inside the outer frame.

#gest(
  duration: 40000000,
  label: ("p", "a", "m"),
  vel: (([wide], 0.72, 0.96),),
  tb: (([narrow\ pharyngeal], 0.20, 0.72),),
  lips: (([clo\ labial], 0.04, 0.23), ([clo\ labial], 0.72, 0.96)),
  glo: (([wide], 0.06, 0.34),),
  border: true,
  axis: true,
)
