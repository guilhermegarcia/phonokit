#import "garcia_functions.typ": *
#import "garcia_slides_r.typ": *
#import "phonokit/lib.typ": *
#phonokit-init(font: "Libertinus Sans")
#show: ex-rules


// NOTE: Specific changes
// #show figure: it => {
//   v(1em)
//   it
//   v(1em)
// }

#set math.equation(numbering: "(1)")
#show math.equation: set text(font: "Libertinus Math")

// NOTE: Code styling (context-aware for pratique slides)
#show raw.where(block: false): it => context {
  let c = if it.lang == none and it.text.starts-with("#") {
    raw(it.text, lang: "typ")
  } else {
    it
  }
  let size = 1em
  let bg = if in-pratique.get() { myYellow.lighten(70%) } else { rgb("#f0f0f0") }
  box(
    fill: bg,
    inset: (x: 3pt, y: 0pt),
    outset: (y: 4pt),
    radius: 3pt,
    text(font: "Berkeley Mono", size: size, fill: blue.darken(10%), c),
  )
}

#show raw.where(block: true): it => context {
  let bg = if in-pratique.get() { myYellow.lighten(50%) } else { luma(240) }
  set text(font: "Berkeley Mono", size: 1em)
  block(
    fill: bg,
    inset: -3pt,
    radius: 4pt,
    width: auto,
    it,
  )
}

#let kit = text(font: "Charis", fill: blue.lighten(5%))[*#emph[k]it*]
#let kit-title = text(font: "Charis", fill: blue.lighten(50%))[*#emph[k]it*]
#let title-logo = text(font: "Charis")[*phono*#kit-title]
#let logo = text(font: "Charis")[*phono*#kit]
#let synkit = text(font: "Charis")[*syn*#kit]

#show: slides.with(
  title: [#title-logo],
  subtitle: "A toolkit to create phonological representations",
  authors: [Guilherme D. Garcia | #text(font: "Berkeley Mono", size: 0.85em)[#link("https://gdgarcia.ca")[gdgarcia.ca]]],
  date: smallcaps("april 2026"),
  short-authors: smallcaps("garcia"),
  ratio: 16 / 9,
  doc-lang: "en",
  layout: "medium",
  title-color: myRed.darken(53%),
  toc: false,
  logo: image("ulaval.png", width: 3cm),
  pauses: false, // false = handout (all content visible)
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== A new language for typesetting documents

#important(title: "Typst")[
  is a new language to typeset documents. It's modern, light, fast and intuitive. Visit #link("https://typst.app")[typst.app] to use their online editor (also check out their excellent tutorials). These slides were made using Typst (a custom version of the #link("https://typst.app/universe/package/diatypst")[Diatypst] template).
]

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== A new package for phonology

#grid(
  columns: (2.5fr, 1fr),
  gutter: 1em,
  [
    - A Typst package for phonology @phonokit_garcia
    - #hl[*Idea*]: generate phonological representations (IPA, prosody, SPE, OT, etc.)
  ],
  [
    #align(right)[#image("phonokit.png", width: 65%)]
  ],
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== What does #LaTeX offer to phonologists?

*Designed for phonology:*
- IPA with `tipa`
- Tableaux with `ot-tableau`
- SPE rules and matrices with math mode and specialized packages, such as `phonrule`
- Vowel trapezoids with `vowel`

*Adapted to phonology:*
- Numbered examples with `linguex` (among others)
- Trees with `tikz` and `tikz-qtree` (meant for syntax)
- Non-linear representations in general with `tikz`

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== What can be improved?

- *Goal:* offer specialized functions that *automate* phonological representations with *minimal syntax*

#v(1em)

#align(center)[
  #figure(
    caption: [Components currently covered by #logo],
  )[
    #table(
      columns: 5,
      align: center,
      inset: (x: 1em, y: 0.6em),
      stroke: (x, y) => (
        left: if x > 0 { 0.5pt + luma(180) } else { none },
        top: if y > 0 { 0.5pt + luma(180) } else { none },
        right: none,
        bottom: none,
      ),
      // fill: (x, y) => if y == 0 { luma(235) } else if calc.even(y) { luma(250) } else { none },
      [IPA], [OT], [Hasse], [MaxEnt; (N)HG], [autosegmental],
      [sonority], [examples], [ToBI], [SPE], [consonants],
      [vowels], [grids], [multi-tier], [feature geometry], [#sym.mu, #sym.sigma, Ft, PWd],
    )
  ]
]

#v(2em)
#winner #logo improves what is already there in #LaTeX and adds #hlv[more]

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Phonetic transcription

#winner Charis is the default font, but you can alter it (these slides use Libertinus Sans)

UTF-8 is supported #hl[natively] in Typst 😌, so you could add phonetic symbols directly (easy but slow)

#v(2em)

#pk-preview(`#ipa("['pE.tSi]")`)
#pk-preview(`#ipa("['b2R \\schwar ,flaI]")`)
#pk-preview(`#ipa("[ma.' \\nh a.na]")`)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Phonemic inventories: vowels & consonants

- Pre-defined languages or custom inventories
#pk-preview(`#vowels("portuguese")`)
#pk-preview(`#vowels("english")`)
#pk-preview(`#vowels("aeioE")`)

#pagebreak()
- Outputs are easy to scale up/down
#pk-preview(`#vowels("\\o iW@", scale: 0.4)`)
#pk-preview(
  `#vowels(
    "english",
    arrows: (
      ("a", "U"),
      ("a", "I"),
      ("e", "I"),
      ("O", "I"),
      ("o", "U"),
    ),
    arrow-color: blue.lighten(60%),
    curved: true,
    highlight: ("a", "e", "o", "O"),
    highlight-color: blue.lighten(80%),
  )`,
  size: 0.8em,
)

#pagebreak()
#pk-preview(`#consonants("portuguese", scale: 0.65)`, horizontal: false)
#pagebreak()
#pk-preview(`#consonants("italian", simplify: true, scale: 0.55)`, horizontal: false)
#pagebreak()
#pk-preview(`#consonants("bpmnNKslL", scale: 0.45)`, horizontal: false)



// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== SPE

- Feature matrices for a given phoneme; matrices for rules + helper functions such as `#blank()`

#v(2em)

#grid(
  columns: (0.5fr, 1fr),
  gutter: 1em,
  align: (top + center, top + center),
  [
    ```typst
    #feat-matrix("\\ae")
    ```
    #text(size: 0.8em)[#feat-matrix("\\ae")]
  ],
  [
    #align(left)[
      ```typst
      #feat("+son", "–approx") #a-r #feat(alpha + [#smallcaps("place")]) / #blank()\]#sub[#sigma] #feat("–son", "–cont", "–del rel", alpha + [#smallcaps("place")])
      ```
    ]

    #feat("+son", "–approx") #a-r #feat(alpha + [#smallcaps("place")]) / #blank()\]#sub[#sigma] #feat("–son", "–cont", "–del rel", alpha + [#smallcaps("place")])

  ],
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Visualizing sonority profiles

- Visual representation of the sonority principle #scite[@parker_sonority_2011]

#v(2em)

#pk-preview(`#sonority("en.kon.tRos", scale: 0.6)`, size: 0.94em)


// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Prosodic representation

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: (top, top),
  [
    #pk-preview(`#syllable("maR", scale: 0.9)`, horizontal: false)
  ],
  [

    #pk-preview(`#mora("maR", coda: true)`, horizontal: false)
  ],
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Prosodic representation

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: (top, top),
  [
    #pk-preview(`#foot("'Su.va", scale: 0.8)`, horizontal: false, size: 0.83em)
  ],
  [
    #pk-preview(`#foot-mora("maR", coda: true, scale: 0.8)`, horizontal: false, size: 0.83em)
  ],
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Prosodic representation

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: (top, top),
  [
    #pk-preview(`#word("('Su.va)", scale: 0.8)`, horizontal: false, size: 0.79em)
  ],
  [
    #pk-preview(`#word-mora("(maR)", coda: true, scale: 0.8)`, horizontal: false, size: 0.79em)
  ],
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Prosodic representation: metrical grids

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: (top, top),
  [
    #pk-preview(`#met-grid("bu2.tter1")`, horizontal: false, size: 0.87em)
  ],
  [
    #pk-preview(`#met-grid(("b2", 2), ("R \\schwar", 1))`, horizontal: false, size: 0.87em)
  ],
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Autosegmental phonology

#pk-preview(
  `#autoseg(
    ("k", "a", "m", "a"),
    features: ("", "", "[+nas]", ""),
    links: ((2,1),),
    spacing: 1.0,
    arrow: false
    )
`,
  size: 0.83em,
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Autosegmental phonology

#pk-preview(
  `#autoseg(
      ("m", "1", "A", "u"),
      features: ("", "", ("H", "L"), ""),
      tone: true,
      links: (((2, 0), 1),),
      highlight: ((2, 0),),
      spacing: 1.0,
      arrow: true,
    )`,
  size: 0.83em,
)


// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Autosegmental phonology

#pk-preview(
  `#autoseg(
      ("e", "b", "e"),
      features: ("L", "", "H"),
      spacing: 0.5,
      tone: true,
      gloss: [])
   #a-r
   #autoseg(
      ("e", "b", "e"),
      features: ("L", "", "H"),
      links: ((0, 2),),
      spacing: 0.5,
      // arrow: true,
      tone: true,
      gloss: [èbě _pumpkin_])`,
  size: 0.85em,
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Prosody with ToBi <tobi>

- Examples from #cite(<zsiga2013sounds>, form: "prose")

#pk-preview(
  `You're a we#int("*L")rewolf?#h(1em)#int("H%", line: false)`,
  size: 0.9em,
  // output-align: (left + horizon),
)

#pk-preview(
  `I'm a wer#int("*H")ewolf.#h(1em)#int("L%", line: false)`,
  size: 0.9em,
  // output-align: (left + horizon),
)

#v(2em)

#winner The function `#int()` works well with numbered examples --- see #link("https://doi.org/10.5281/zenodo.18260076")[manual] and #slideref(<tobi-example>) #a-d

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Multi-tier representations

#grid(
  columns: (1fr, 1.5fr),
  gutter: 1em,
  align: (center + horizon, left + horizon),
  [
    #multi-tier(
      show-grid: false,
      levels: (
        ("", "", "", "", ("Adj", 3.5)),
        ("", "", "", "", ("Adj", 3.5)),
        ("", ("Af", 0.5), "", ("N", 2.5), "Af"),
        ("in", "ter", "na", "tion", "al"),
        ("sigma", "sigma", "sigma", "sigma", "sigma"),
        ("Sigma", "", "Sigma", "", ""),
        ("", "", "omega", "", ""),
      ),
      links: (
        ((0, 4), (2, 1)), // Adj -> Af
        ((1, 4), (2, 3)), // Adj -> N
        ((2, 1), (3, 0)), // Af -> in
        ((2, 3), (3, 2)), // N -> na
        ((5, 0), (4, 1)), // Ft -> Syl
        ((5, 2), (4, 3)), // Ft -> Syl
        ((6, 2), (5, 0)), // PWd -> Ft
        ((6, 2), (4, 4)), // PWd -> Ft
      ),
      scale: 0.8,
    )
  ],
  [

    - Function `#multi-tier()`: *very flexible*
    - Wide range of arguments based on a #hl[grid architecture]
    - Helper: temporary grid with coordinates
    - Figure adapted from #cite(<booij2012grammar>, form: "prose")

    #winner Let's unpack this figure and its code


  ],
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Multi-tier representations

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  align: (left + horizon, center + horizon),
  {
    set text(size: 1em)
    [
      ```typst
      #multi-tier(
        show-grid: false,
        levels: (
          ("", "", "", "", ("Adj", 3.5)),
          ("", "", "", "", ("Adj", 3.5)),
          ("", ("Af", 0.5), "", ("N", 2.5), "Af"),
          ("in", "ter", "na", "tion", "al"),
          ("sigma", "sigma", "sigma", "sigma", "sigma"),
          ("Sigma", "", "Sigma", "", ""),
          ("", "", "omega", "", ""),
        ),
        scale: 0.8,
       )```

    ]
  },
  [
    #multi-tier(
      show-grid: false,
      levels: (
        ("", "", "", "", ("Adj", 3.5)),
        ("", "", "", "", ("Adj", 3.5)),
        ("", ("Af", 0.5), "", ("N", 2.5), "Af"),
        ("in", "ter", "na", "tion", "al"),
        ("sigma", "sigma", "sigma", "sigma", "sigma"),
        ("Sigma", "", "Sigma", "", ""),
        ("", "", "omega", "", ""),
      ),
      scale: 0.8,
    )
  ],
)

- Any element projects *one* line/link by default (this can be deleted later with `delinks`)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Multi-tier representations

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  align: (left + horizon, center + horizon),
  {
    set text(size: 0.85em)
    [
      ```typst
      #multi-tier(
            show-grid: true, // <- HELPER GRID
            levels: (
              ("", "", "", "", ("Adj", 3.5)),
              ("", "", "", "", ("Adj", 3.5)),
              ("", ("Af", 0.5), "", ("N", 2.5), "Af"),
              ("in", "ter", "na", "tion", "al"),
              ("sigma", "sigma", "sigma", "sigma", "sigma"),
              ("Sigma", "", "Sigma", "", ""),
              ("", "", "omega", "", ""),
            ),
            scale: 0.8,
          )```

    ]
  },
  [
    #multi-tier(
      show-grid: true,
      levels: (
        ("", "", "", "", ("Adj", 3.5)),
        ("", "", "", "", ("Adj", 3.5)),
        ("", ("Af", 0.5), "", ("N", 2.5), "Af"),
        ("in", "ter", "na", "tion", "al"),
        ("sigma", "sigma", "sigma", "sigma", "sigma"),
        ("Sigma", "", "Sigma", "", ""),
        ("", "", "omega", "", ""),
      ),
      scale: 0.8,
    )
  ],
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Multi-tier representations

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  align: (left + horizon, center + horizon),
  {
    set text(size: 0.80em)
    [
      ```typst
      #multi-tier(
            show-grid: true,
            levels: (
              ("", "", "", "", ("Adj", 3.5)),
              ("", "", "", "", ("Adj", 3.5)),
              ("", ("Af", 0.5), "", ("N", 2.5), "Af"),
              ("in", "ter", "na", "tion", "al"),
              ("sigma", "sigma", "sigma", "sigma", "sigma"),
              ("Sigma", "", "Sigma", "", ""),
              ("", "", "omega", "", ""),
            ),
            scale: 0.8,
            links: (
            ((0, 4), (2, 1)), // Adj -> Af
            ((1, 4), (2, 3)), // Adj -> N
            ((2, 1), (3, 0)), // Af -> in
            ((2, 3), (3, 2)), // N -> na
            ((5, 0), (4, 1)), // Ft -> Syl
            ((5, 2), (4, 3)), // Ft -> Syl
            ((6, 2), (5, 0)), // PWd -> Ft
            ((6, 2), (4, 4)), // PWd -> Ft
            ),
          )```

    ]
  },
  [
    #multi-tier(
      show-grid: true,
      levels: (
        ("", "", "", "", ("Adj", 3.5)),
        ("", "", "", "", ("Adj", 3.5)),
        ("", ("Af", 0.5), "", ("N", 2.5), "Af"),
        ("in", "ter", "na", "tion", "al"),
        ("sigma", "sigma", "sigma", "sigma", "sigma"),
        ("Sigma", "", "Sigma", "", ""),
        ("", "", "omega", "", ""),
      ),
      scale: 0.8,
      links: (
        ((0, 4), (2, 1)), // Adj -> Af
        ((1, 4), (2, 3)), // Adj -> N
        ((2, 1), (3, 0)), // Af -> in
        ((2, 3), (3, 2)), // N -> na
        ((5, 0), (4, 1)), // Ft -> Syl
        ((5, 2), (4, 3)), // Ft -> Syl
        ((6, 2), (5, 0)), // PWd -> Ft
        ((6, 2), (4, 4)), // PWd -> Ft
      ),
    )
  ],
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Government Phonology

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  align: (left + horizon, center + horizon),
  {
    set text(size: 0.8em)
    [
      ```typst
      #multi-tier(
            levels: (
              ("O", "R", "", "O", "R", "O", "R"),
              ("", "N1", "", "", "N2", "", "N3"),
              ("", "x", "x", "x", "x", "x", "x"),
              ("", "", "s", "t", "E", "m", ""),
            ),
            links: (
              ((0, 1), (2, 2)),
            ),
            ipa: (3,),
            arrows: (
              ((3, 3), (3, 2)),
              ((0, 4), (0, 1)),
            ),
            arrow-delinks: (
              (1,)
            ),
            spacing: 1, scale: 0.9,
          )```
    ]
  },
  [
    #multi-tier(
      // show-grid: true,
      levels: (
        ("O", "R", "", "O", "R", "O", "R"),
        ("", "N1", "", "", "N2", "", "N3"),
        ("", "x", "x", "x", "x", "x", "x"),
        ("", "", "s", "t", "E", "m", ""),
      ),
      links: (
        ((0, 1), (2, 2)),
      ),
      ipa: (3,),
      arrows: (
        ((3, 3), (3, 2)),
        ((0, 4), (0, 1)),
      ),
      arrow-delinks: (
        (1,)
      ),
      spacing: 1,
      scale: 0.9,
    )

    Adapted from #cite(<goad2012sc>, form: "prose")
  ],
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== CV phonology

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  align: (left + horizon, center + horizon),
  {
    set text(size: 0.8em)
    [
      ```typst
       #multi-tier(
        levels: (
          ("T", "", "R", ""),
          ("O1", "n1", "O2", "n2"),
          ("x", "", ("x", 2.5), ""),
          ("o", "", ("N", 2.5), ""),
          ("", "", ("V", 2.5), ""),
        ),
        links: (((1, 3), (2, 2)),),
        dashed: (((2, 0), (3, 2)),),
        level-spacing: 1.2,
        highlight: ((1, 0),),
        spacing: 1,
        stroke-width: 0.7pt,
        tier-labels: (
          (1, "C-plane"),
          (2, "skeleton"),
          (3, "V-plane"),),
        scale: 0.9,
      )```
    ]
  },
  [
    #multi-tier(
      levels: (
        ("T", "", "R", ""),
        ("O1", "n1", "O2", "n2"),
        ("x", "", ("x", 2.5), ""),
        ("o", "", ("N", 2.5), ""),
        ("", "", ("V", 2.5), ""),
      ),
      links: (
        ((1, 3), (2, 2)),
      ),
      dashed: (
        ((2, 0), (3, 2)),
      ),
      level-spacing: 1.2,
      highlight: (
        (1, 0),
      ),
      spacing: 1,
      stroke-width: 0.7pt,
      tier-labels: (
        (1, "C-plane"),
        (2, "skeleton"),
        (3, "V-plane"),
      ),
      scale: 0.9,
    )

    Adapted from #cite(<carvalho2017deriving>, form: "prose")
  ],
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Feature Geometry: consonants (full structure)

#pk-preview(
  `#geom(
  root: ("±son", "±approx", "-vocoid"),
  spread: true,
  constricted: true,
  nasal: true,
  voice: true,
  labial: true,
  coronal: true, // <- implied
  anterior: true,
  distributed: true,
  dorsal: true,
  continuant: true,
)`,
  size: 0.8em,
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Feature Geometry: vocoids (full structure)

#pk-preview(
  `#geom(
  root: ("+son", "+approx", "+vocoid"),
  spread: true,
  constricted: true,
  nasal: true,
  vplace: true, // <- implied
  labial: true,
  aperture: (true, true, true),
  coronal: true,
  anterior: "-",
  distributed: true,
  dorsal: true,
  continuant: true,
  scale: 0.9,
)`,
  size: 0.8em,
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Feature Geometry: presets

#pk-preview(
  `#geom(ph: "a")`,
)

#pk-preview(
  `#geom(ph: "a",
  aperture: ("+",))`,
)

#pk-preview(
  `#geom(ph: "a",
  model: "sagey",
  scale: 0.9)`,
)

#pk-preview(
  `#geom(ph: "i:")`,
)

#pk-preview(
  `#geom(ph: "i:",
  timing: ("mora", "mora"))`,
)

#pk-preview(
  `#geom(ph: "tS")`,
)

== Multiple trees: processes

#pk-preview(
  `#geom-group(
    (ph: "/a/"),
    (ph: "/n/"),
    arrows: (
      (from: "nasal2",
       to: "root1",
       ctrl: (1.1, -1.5)),
       ),
    curved: true, // <- implied
    gap: 1,
  )`,
  size: 0.9em,
)

#pk-preview(
  `#geom-group(
  (ph: "/e/"),
  (ph: "\\C"),
  (ph: "/u/", prefix: "-"),
  arrows: (
    (from: "high3",
     to: "dorsal1",
     ctrl: (2.3, -1.5)),
  ),
  delinks: ("high1",),
  gap: 1.5,
  model: "sagey",
  scale: 0.8
)`,
  size: 0.9em,
)

#pk-preview(
  `#geom-group(
  (ph: "/e/"),
  (ph: "\\C"),
  (ph: "/u/", prefix: "-"),
  arrows: (
    (from: "high3",
     to: "dorsal1",
     ctrl: (2.3, -1.5)),
  ),
  delinks: ("high1",),
  highlight: (
     "high1", "dorsal1", "high3"
  ),
  gap: 1.5,
  model: "sagey",
  scale: 0.8
)`,
  size: 0.9em,
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== OT

- Dynamic tableaux with auto shading (optional)

#v(2em)

#grid(
  columns: (1.4fr, 1fr),
  gutter: 1em,
  align: (left + horizon, center + horizon),
  {
    set text(size: 1em)
    [
      ```typst
      #tableau(
          input: "/kraTa/",
          candidates: ("kra.Ta", "ka.Ta", "ka.ra.Ta"),
          constraints: ("Max", "Dep", "*Complex"),
          violations: (
          ("", "", "*"),
          ("*!", "", ""),
          ("", "*!", ""), ),
          winner: 0,
          dashed-lines: (0,),
          shade: true, // <- auto shading after !
          letters: true,
      )```
    ]
  },
  [
    #tableau(
      input: "/kraTa/",
      candidates: ("kra.Ta", "ka.Ta", "ka.ra.Ta"),
      constraints: ("Max", "Dep", "*Complex"),
      violations: (
        ("", "", "*"),
        ("*!", "", ""),
        ("", "*!", ""),
      ),
      winner: 0,
      dashed-lines: (0,),
      shade: true,
      letters: true,
    )
  ],
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== OT

- Prosodic representation of candidates (subset of previous tableau shown here) --- see manual
- Existing functions can be combined: `#foot()` inside `#tableau()`

#v(2em)

#align(center)[
  #tableau(
    input: "/kraTa/",
    candidates: (
      [#foot("kra.Ta", scale: 0.8)],
    ),
    constraints: ("Max", "Dep", "*Complex"),
    violations: (
      ("", "", "*"),
    ),
    winner: 0,
    dashed-lines: (0,),
    shade: true,
  )
]

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Hasse diagrams

- Visualizing OT rankings with minimal syntax and with automatic small caps

#v(2em)

#grid(
  columns: (1.45fr, 1fr),
  gutter: 1em,
  align: (left + horizon, center + horizon),
  {
    set text(size: 1em)
    [
      ```typst
      #hasse(
          (
          ("*Complex", "Max", 0),
          ("*Complex", "Dep", 0),
          ("Onset", "Max", 0),
          ("Onset", "Dep", 0),
          ("Max", "NoCoda", 1),
          ("Dep", "Constraint[Feat]", 1, "dotted"),
          ),
          node-spacing: 3,
      )```
    ]
  },
  [
    #hasse(
      (
        ("*Complex", "Max", 0),
        ("*Complex", "Dep", 0),
        ("Onset", "Max", 0),
        ("Onset", "Dep", 0),
        ("Max", "NoCoda", 1),
        ("Dep", "Constraint[Feat]", 1, "dotted"),
      ),
      node-spacing: 3,
    )
  ],
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Harmonic Grammar

- Weights and violation counts are used to automatically compute harmony scores ($h_i$)

#v(2em)

#grid(
  columns: (1.7fr, 1.2fr),
  gutter: 1em,
  align: (top, center + horizon),

  {
    set text(size: 0.9em)
    [
      ```typst
      #hg(
          input: "/kraTa/",
          candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
          constraints: ("Max", "Dep", "*Complex"),
          weights: (2.5, 1.8, 0.5),
          violations: (
            (0, 0, -1),
            (-1, 0, 0),
            (0, -1, 0),
          ),
          scale: 0.8,
          )```

    ]
  },
  [
    #align(center)[
      #hg(
        input: "/kraTa/",
        candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
        constraints: ("Max", "Dep", "*Complex"),
        weights: (2.5, 1.8, 0.5),
        violations: (
          (0, 0, -1),
          (-1, 0, 0),
          (0, -1, 0),
        ),
        scale: 0.8,
      )
    ]
  ],
)




// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Noisy Harmonic Grammar

- Probabilities simulated (Monte Carlo) based on `num-simulations` (default: `1000`)
- $epsilon_i$ #a-r single noise sample shown for illustration --- not used by $P_i$

#v(2em)

#grid(
  columns: (1.3fr, 1.3fr),
  gutter: 1em,
  align: (top, center + horizon),

  {
    set text(size: 0.9em)
    [

      ```typst
      #nhg(
        input: "/kraTa/",
        candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
        constraints: ("Max", "Dep", "*Complex"),
        weights: (2.5, 1.8, 0.5),
        violations: (
          (0, 0, -1),
          (-1, 0, 0),
          (0, -1, 0),
        ),
        scale: 0.7,
        letters: true,
      )```

    ]
  },
  [
    #align(center)[
      #nhg(
        input: "/kraTa/",
        candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
        constraints: ("Max", "Dep", "*Complex"),
        weights: (2.5, 1.8, 0.5),
        violations: (
          (0, 0, -1),
          (-1, 0, 0),
          (0, -1, 0),
        ),
        scale: 0.7,
        letters: true,
      )
    ]
  ],
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== MaxEnt

- MaxEnt tableaux with automatic calculation and optional probability visualization

#grid(
  columns: 1fr,
  gutter: 1em,
  align: (center),
  [
    #maxent(
      input: "/kraTa/",
      candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
      constraints: ("Max", "Dep", "*Complex"),
      weights: (2.5, 1.8, 0.5),
      scale: 0.8,
      violations: (
        (0, 0, 1),
        (1, 0, 0),
        (0, 1, 0),
      ),
      visualize: true,
    )

    #maxent(
      input: "/kraTa/",
      candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
      constraints: ("Max", "Dep", "*Complex"),
      weights: (2.5, 1.8, 0.5),
      scale: 0.8,
      violations: (
        (0, 0, 1),
        (1, 0, 0),
        (0, 1, 0),
      ),
      visualize: false,
    )
  ]
)

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== MaxEnt

- MaxEnt tableaux with automatic calculation and optional probability visualization

#v(2em)

#align(center)[
  #grid(
    columns: auto,
    gutter: 1em,
    align: (left + horizon),
    {
      set text(size: 1em)
      [
        ```typst
        #maxent(
            input: "/kraTa/",
            candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
            constraints: ("Max", "Dep", "*Complex"),
            weights: (2.5, 1.8, 0.5),
            violations: (
              (0, 0, 1),
              (1, 0, 0),
              (0, 1, 0),
            ),
            visualize: true, // <- visualization
            sort: true, // <- sort candidates by probability
        )```
      ]
    },
  )
]

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== MaxEnt

- You can also easily sort candidates by $P_i$ with `sort: true` as of version `0.4.1`

#grid(
  columns: 1fr,
  gutter: 1em,
  align: (center),
  [
    #maxent(
      input: "/kraTa/",
      candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
      constraints: ("Max", "Dep", "*Complex"),
      weights: (2.5, 1.8, 0.5),
      scale: 0.8,
      violations: (
        (0, 0, 1),
        (1, 0, 0),
        (0, 1, 0),
      ),
      visualize: true,
    )

    #maxent(
      input: "/kraTa/",
      candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
      constraints: ("Max", "Dep", "*Complex"),
      weights: (2.5, 1.8, 0.5),
      scale: 0.8,
      violations: (
        (0, 0, 1),
        (1, 0, 0),
        (0, 1, 0),
      ),
      visualize: true,
      sort: true,
    )
  ]
)


// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Numbered examples

- Phonology-friendly numbered examples: @ex-anba and @ex-anka are easy to reference
- Use `&` to separate columns; optional `columns` for explicit widths; optional caption ToC

#v(2em)

#align(center)[
  #grid(
    columns: 1,
    gutter: 1em,
    align: left + horizon,
    {
      set text(size: 0.9em)
      [
        ```typst
        #show: ex-rules // <- this must be added to your preamble once
        #ex(labels: (<ex-anba>, <ex-anka>))[
          - #ipa("/anba/") & #a-r & #ipa("[amba]")
          - #ipa("/anka/") & #a-r & #ipa("[aNka]")
        ] <phon-ex>
        ```
      ]
    },
    [
      #ex(labels: (<ex-anba>, <ex-anka>))[
        - #ipa("/anba/") & #a-r & #ipa("[amba]")
        - #ipa("/anka/") & #a-r & #ipa("[aNka]")
      ] <phon-ex>
    ],
  )
]

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Numbered examples <tobi-example>

- Here's an example of a *numbered example with ToBI*
- You can refer to @ex-tobi1 and @ex-tobi2. As of version `0.4.6`, `title` is also available for examples:

#grid(
  columns: 1,
  gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    // #figure(
    //   supplement: "Code",
    //   kind: "code",
    //   caption: [Numbered example with ToBI (notice table alignment)],
    //   ```typst
    //     // #import "@preview/phonokit:0.4.6"
    //     // #show: ex-rules // <- this must be added to your doc
    //     // ...
    //     #ex(caption: "Some ToBI examples", title: [Autosegmental transcription of intonation in English @zsiga2013sounds])[
    //     #table(
    //       columns: (4em, 15em),
    //       stroke: none,
    //       align: left + bottom,
    //     // NOTE: ESSENTIAL TO ADD "bottom" HERE
    //       [#subex-label()<ex-tobi1>], [You're a we#int("*L")rewolf?#h(1em)#int("H%", line: false)],
    //       [#subex-label()<ex-tobi2>], [I'm a wer#int("*H")ewolf.#h(1em)#int("L%", line: false)],
    //     )
    //   ] <tobi-ex>
    //   ```,
    // ) <code-tobi>
  ],
  [
    #ex(
      caption: "Some ToBI examples",
      title: [Autosegmental transcription of intonation in English @zsiga2013sounds],
    )[
      #table(
        columns: (4em, 15em),
        stroke: none,
        align: left + bottom,
        // NOTE: ESSENTIAL TO ADD "bottom" HERE
        [#subex-label()<ex-tobi1>], [You're a we#int("*L")rewolf?#h(1em)#int("H%", line: false)],
        [#subex-label()<ex-tobi2>], [I'm a wer#int("*H")ewolf.#h(1em)#int("L%", line: false)],
      )
    ] <tobi-ex>
  ],
)

#h(1fr)go back to #slideref(<tobi>) #a-u

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


== FAQ

#pratique(title: [#icon-tip Common questions])[
  1. Do I need to adopt Typst to take advantage of #logo?
  2. Can I completely replace #LaTeX with Typst in 2026?
  3. How about my `bib` references?
  4. What _can't_ I do with Typst yet?
  5. What editor/IDE do I need to use it?
]

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== FAQ & final thoughts

#correction(title: [])[
  1. No. You can export outputs as `PNG` and use them in #LaTeX, Word, etc. Pair it with `oxipng` for tiny file sizes. See workflow example in #cite(<phonokit_garcia>, form: "prose", supplement: "appendix").
  2. That depends. Journals will take a while to accept `typ`, and very few people know Typst. But you don't have to choose: they're two useful tools/languages. If you work in phonology, you _could_ probably use Typst 99% of the time. In syntax, #LaTeX still offers more when it comes to trees...
  3. They work with Typst. So your workflow will not be affected.
  4. #LaTeX is much older, so it has *many* more packages. What you can/can't do depends on what packages your workflow requires.
  5. VS Code, Positron, NeoVim, etc. Use `tinymist` as your extension/plugin.
]


// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// == Forthcoming
//
// - Inuktitut conversion with dialect specification
// - Feature geometry

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Future: phonology

- #logo is already stable and covers a wide range of scenarios
- Main goal moving forward: *polish* existing functions (_secondary goal: additional functions?_)

#important(title: "More info:")[
  #link("https://doi.org/10.5281/zenodo.17971031")[Check manual] for examples of all available functions #h(1fr)#link("https://doi.org/10.5281/zenodo.17971031")[#box(baseline: 20%)[#image("zenodo-badge.svg", height: 1em)]]
]


#v(1em)

#align(center)[

  #fa-earth-americas() #link("https://gdgarcia.ca/phonokit")[`gdgarcia.ca/phonokit`]

  #fa-github() #link("https://github.com/guilhermegarcia/phonokit")[`guilhermegarcia/phonokit`]

  #fa-comment() #link("https://github.com/guilhermegarcia/discussions")[`guilhermegarcia/phonokit/discussions`]

  #fa-bug() #link("https://github.com/guilhermegarcia/phonokit/issues")[`guilhermegarcia/phonokit/issues`]

]

#v(1em)

#winner *But*: to adopt Typst in linguistics, we need to go beyond phonology

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== Future: Typst in linguistics?

- #synkit, a new package for syntax trees, glosses, and in-line movement
  - Intuitive syntax, *minimal code*, smart functions, automatic labels: same philosophy as #logo
  - Version `0.0.1` will be released before summer 2026
  - #hl[*Coverage*]: complex trees (syntax/semantics), arrows, in-line movement, glosses


// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== References

#show bibliography: set text(size: 0.8em)
#bibliography("references.bib", style: "apa")

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#heading(numbering: none)[Appendix]

// SLIDE: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

== From #LaTeX to Typst

#winner If you're coming from #LaTeX, here are some equivalent packages:

#v(1em)

#figure(
  align(center)[
    #table(
      columns: 2,
      stroke: none,
      gutter: 0.2em,
      inset: (y: 0.35em),
      table.hline(stroke: 0.8pt + black),
      [#LaTeX], [Typst],
      table.hline(stroke: 0.4pt + black),
      [tipa], [#link("https://typst.app/universe/package/phonokit")[phonokit]],
      [tikz], [#link("https://typst.app/universe/package/cetz")[cetz]],
      [tikz-qtree], [#link("https://typst.app/universe/package/syntree")[syntree]],
      [linguex], [#link("https://typst.app/universe/package/eggs")[eggs]],
      [glossaries], [#link("https://typst.app/universe/package/glossarium")[glossarium]],
      table.hline(stroke: 0.8pt + black),
    )
  ],
)

