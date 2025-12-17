#import "lib.typ": *

#set math.equation(numbering: "(1)")
#show raw.where(block: false): it => {
  let content = if it.lang == none and it.text.starts-with("#") {
    raw(it.text, lang: "typ")
  } else {
    it
  }
  let size = if it.text.starts-with("#") { 1.1em } else { 1em }
  box(
  fill: rgb("#f0f0f0"),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 5pt),
  radius: 10pt,
  text(font: "Berkeley Mono", size: size, fill: rgb("#c7254e"), content)
)
}

// NOTE: Code block

#show raw.where(block: true): it => {
  set text(font: "Berkeley Mono", size: 1em)
  block(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  width: auto,
  it
)
}

// NOTE: Helper for showing code and output side-by-side
#let show-example(code, output) = {
  grid(
    columns: (1.2fr, 1fr),
    gutter: 1em,
    align(left + horizon, code),
    align(center + horizon, output)
  )
}

// NOTE: Paragraph
#set par(
  first-line-indent: 2em,
  spacing: 1em,
  leading: 1em,
  justify: true,
  hanging-indent: 0em
)

// #set figure(supplement: "Fig.")
#set figure(gap: 1em)



// NOTE: Text
#set text(font: "Charis SIL", size: 10pt, lang: "en", hyphenate: auto)

// NOTE: Margins
#set page(margin: (
  top: 2cm,
  bottom: 2cm,
  left: 2.5cm,
  right: 2.5cm),
  numbering: "1",
  number-align: center
)

// NOTE: Define LaTeX command/logo
#let LaTeX = {
  let A = (
    offset: (
      x: -0.33em,
      y: -0.3em,
    ),
    size: 0.7em,
  )
  let T = (
    x_offset: -0.12em    
  )
  let E = (
    x_offset: -0.2em,
    y_offset: 0.23em,
    size: 1em
  )
  let X = (
    x_offset: -0.1em
  )
  [L#h(A.offset.x)#text(size: A.size, baseline: A.offset.y)[A]#h(T.x_offset)T#h(E.x_offset)#text(size: E.size, baseline: E.y_offset)[E]#h(X.x_offset)X]
}

// NOTE: Adjust heading numbering and justification
#set heading(
  numbering: "1.1.",
)

#show heading: it => {
  v(1em)
  it
  v(0.5em)
}

#show figure: it => {
  v(1em)
  it 
  v(1em)
}



// NOTE: Link colors
#show link: set text(fill: blue)

// NOTE: Begin doc here

#title([Phonokit: a Typst package for phonology]) \
_Guilherme D. Garcia_ • #smallcaps[université laval] \ Last updated on #datetime.today().display("[month repr:long] [day], [year]")

= Introduction <sec-intro>

I have used #LaTeX @lamport1994latex @knuth1984texbook for over a decade, and it has been a central part of my workflow: slides, articles, posters, handouts, letters, statements, books. If you have custom-made templates and macros (especially when paired with snippets), it is difficult to beat the quality and efficiency of #LaTeX, especially if you are attentive to detail and enjoy typography overall. However, for all its pros, #LaTeX certainly has its cons.

#LaTeX has a steep learning curve, especially for students who have zero experience with coding --- it doesn't help that its error messages are often cryptic. #LaTeX also has slow compilation times. Typst is a new language that addresses all these shortcomings: it compiles nearly instantaneously, it is more intuitive and user-friendly, and it's _light_. On top of that, it is a proper scripting language, which means complex tasks that require dozens of lines of #LaTeX can frequently be accomplished in just a few lines of Typst. 

The transition from #LaTeX to Typst within my workflow is the reason why Phonokit exists. As I went down my list of must-haves for my typesetting needs, I started to create different functions and templates. The package is thus a collection of those functions. Its goal is very simple: to simplify and speed up all the essential typesetting elements a phonologist needs when producing documents, including phonetic transcription, tables of phonemic inventories, prosodic representations, rewrite rules, and optimality-theoretical tableaux. These represent about 90% of everything I need when preparing class notes and slides, or when writing up papers.

This vignette introduces Phonokit and its main functions. Comments and suggestions are more than welcome, as are bug reports, of course. The repository for the package can be found at XXX.

= IPA module <sec-ipa-module>

IPA transcription is likely the most commonly used feature when typesetting documents in phonology. Phonokit accomplishes that with the `#ipa()` function, which takes a string as input. Crucially, the function uses the familiar `tipa` input @tipa, with a few exceptions (e.g., secondary stress is represented by a comma `,`, not by two double quotes `""`). 


== Phonemic transcription <sec-ipa-trans>

As can be seen in @fig-ipa-examples, symbols introduced by two backslashes `\\` must not have adjacent characters. Note that all functions in Phonokit require the Charis SIL font @charis_sil, regardless of the font used in the document. 

#figure(
  caption: [Transcriptions using `#ipa()`], 
  supplement: "Code example",
  kind: "code",
table(
    columns: (auto, auto, auto),
    stroke: none,
    align: left,
    [`#ipa("DIs \\s Iz \\s @ \\s sEn.t@ns")`], ipa("DIs \\s Iz \\s @ \\s sEn.t@ns"), [_This is a sentence_],
    [`#ipa("p \\h I k \\* \\s \\t tS \\ae t \\s p \\r l iz")`], ipa("p \\h I k \\* \\s \\t tS \\ae t \\s p \\r l iz"), [_Pick, chat, please_],
    [`#ipa("'lIt \\v l \\s 'b2R \\schwar , flaI")`], ipa("'lIt \\v l \\s 'b2R \\schwar , flaI"), [_Little butterfly_]
  )
) <fig-ipa-examples>


== Phonemic inventories

Two additional functions allow users to quickly create consonant tables and vowel trapezoids given a string of phonemes. @fig-consonants-pt shows the consonant inventory for (Brazilian) Portuguese, for example. The function mirrors the pulmonic consonants table in the IPA chart with some minor changes. For example, affricates are shown when `affricates: true`, and #ipa("/w/") is shown in the approximant row under both bilabial and velar columns (when #ipa("/ \\textturnmrleg /") is not present, in which case #ipa("/w/") appears only under bilabial).

Aspirated consonants are shown when `aspirated: true`, which allows for aspirated affricates in Mandarin to be displayed, for example (@fig-consonants-mandarin). When neither `affricates` nor `aspirated` are set to `true`, the function will omit both groups (e.g., @fig-consonants-pt) and fewer rows will be printed.

#figure(
  caption: [`#consonants("portuguese")`],
  consonants("portuguese"),
) <fig-consonants-pt>

The user can either input a language (see caption of @fig-consonants-pt) or a string of consonants to create a custom inventory --- the input follows the same format used by the `#ipa()` function discussed in @sec-ipa-trans, so `#ipa("\\* r")` generates "#ipa("\\*r")". Finally, the function also allows for flexible sizing with the `scale` argument, shown in @fig-consonants-mandarin.


#figure(
  caption: [`#consonants("mandarin", aspirated: true, affricates: true, scale: 0.6)`],
  consonants("mandarin", aspirated: true, affricates: true, scale: 0.6)
) <fig-consonants-mandarin>

Besides the function `#consonants()`, the package also has a function to print vowel inventories. The function `#vowels()` also accepts either a pre-defined language or a string as input. @fig-vowels-english and @fig-vowels-french show the inventories for English and French, respectively. The argument `scale` is also available here, so the user can adjust the size of the trapezoid as needed.

#grid(
  columns: (1fr, 1fr),
  [#align(center + bottom)[
#figure(
  caption: [`#vowels("english", scale: 0.6)`],
  vowels("english", scale: 0.6)
) <fig-vowels-english>
  ]],
  [#align(center + bottom)[
#figure(
  caption: [`#vowels("french", scale: 0.6)`],
  vowels("french", scale: 0.6)
) <fig-vowels-french>
]]
)




= Prosody module

== Sonority

When discussing the sonority principle in introductory phonology courses, it is often useful to illustrate relative sonority with a visual representation. The function `#plot-son()`, based on the Fonology package for R @fonology, plots phonemes and their relative sonority profiles. The function is based on the sonority scale in #cite(<parker_sonority_2011>, form: "prose", supplement: [p. 18]), but the user is free to adjust the scale as needed in the source code.

#figure(
  caption: [`#plot-son("b2.t \\schwar . flaI")`],
  plot-son("b2.t \\schwar . flaI", scale: 0.9)
) <fig-son1>

@fig-son1 shows an example for the word "butterfly". If syllable boundaries are detected in the input, the function alternates between white and gray fills to distinguish each syllable. If no boundaries are detected, all boxes will be white by default.


== Syllables

We start with an essential representation, namely the syllable. Two options are available: `#syllable()` for a classic onset-rhyme representation (@fig-syl1), and `#mora(..., coda: true)` for a moraic representation (@fig-syl2). The latter option allows you to define whether or not codas project a mora (`coda: true`). These two functions are used for single-syllable representations only. As can be seen in the figures, these functions take as input a string that should be familiar given the discussion about `#ipa()` in @sec-ipa-trans.

#grid(
  columns: (1fr, 1fr),
  [#align(center + bottom)[
#figure(
  caption: [`#syllable("\\t tS \\ae t")`],
  syllable("\\t tS \\ae t", scale: 0.9)
) <fig-syl1>
  ]],
  [#align(center + bottom)[
#figure(
  caption: [`#mora("\\t tS \\ae t", coda: true)`],
  mora("\\t tS \\ae t", coda: true, scale: 0.9)
) <fig-syl2>
]]
)


Vowel length is also represented in both `#syllable()` and `#mora()`, as can be seen in @fig-syl-long and @fig-mora-long, respectively. The crucial element here is the use of `:`, which triggers the #ipa(":") symbol for both representations. In the moraic representation, two moras branch out of the vowel, as expected.

#grid(
  columns: (1fr, 1fr),
  [#align(center + bottom)[
#figure(
  caption: [`#syllable("tR \\~ a:m")`],
  syllable("tR \\~ a:m", scale: 0.9)
) <fig-syl-long>
  ]],
  [#align(center + bottom)[
#figure(
  caption: [`#mora("tR \\~ a:m", coda: true)`],
  mora("tR \\~ a:m", coda: true, scale: 0.9)
) <fig-mora-long>
]]
)


The dimensions of each representation adjust as a function of how many segments are found in the input. As such, more complex onsets, nuclei or codas result in wider representations that respect a safe and consistent between-segment distance. @fig-syl3 illustrates this with an extreme example.

#figure(
  caption: [How spacing is managed],
  syllable("xxxxxaaaaaxxxxx", scale: 0.9)
) <fig-syl3>



We often need to adjust the size of a representation as a whole. But doing so can be problematic if the text and the representation itself behave independently. Here, however, representations can be easily adjusted with the argument `scale`, which takes care of both line width and text size. Examples are shown in @fig-scale075, @fig-scale05 and @fig-scale025.


#grid(
  columns: (1fr, 1fr, 1fr),
  [#align(center + bottom)[
  #figure(
  syllable("\\t tS \\ae t", scale: 0.75),
    caption: [Scale 0.75]
  )<fig-scale075>
]],
[#align(center + bottom)[
  #figure(
  syllable("\\t tS \\ae t", scale: 0.5),
    caption: [Scale 0.5]
  )<fig-scale05>
]],
  [#align(center + bottom)[
  #figure(
  syllable("\\t tS \\ae t", scale: 0.25),
    caption: [Scale 0.25]
  )<fig-scale025>
]]
)


== Feet

Next, we examine metrical feet (@fig-ft1 and @fig-ft2). These functions are designed to deal with a single foot where all syllables are footed by definition, since unfooted syllables have nowhere to attach to (see @sec-pwd). A period `.` is used to indicate syllabification and a single apostrophe `'` is used to indicate which syllable is the head of the foot. This allows us to easily create trochees and iambs. Naturally, you are free to generate non-binary feet, as the function can handle them as well (dactyls in @fig-ft3 and @fig-ft4).

#grid(
  columns: (1fr, 1fr),
  [#align(center + bottom)[
#figure(
  caption: [`#foot("'p \\h \\ae.\\*r Is")`],
  foot("'p \\h \\ae.\\*r Is", scale: 0.9)
) <fig-ft1>
  ]],
  [#align(center + bottom)[
#figure(
  caption: [`#foot-mora("po.'Ra", coda: true)`],
  foot-mora("po.'Ra", coda: true, scale: 0.9)
) <fig-ft2>
]]
)

#grid(
  columns: (1fr, 1fr),
  [#align(center + bottom)[
#figure(
  caption: [`#foot("'po.Ra.ma")`],
  foot("'po.Ra.ma", scale: 0.9)
) <fig-ft3>
  ]],
  [#align(center + bottom)[
#figure(
  caption: [`#foot-mora("'po.Ra.ma")`],
  foot-mora("'po.Ra.ma", coda: true, scale: 0.9)
) <fig-ft4>
]]
)


Geminates are also represented by the functions `#foot()` and `#foot-mora()`. In onset-rhyme representations, a geminate will be linked to the coda and the following onset, as expected. In moraic representations, the user will probably want to define `coda: true` to represent geminates in a traditional fashion. @fig-ft5 and @fig-ft6 show a disyllabic word containing a geminate in both onset-rhyme and moraic representations. The two figures alternate the stress position to illustrate right- and left-headed feet --- it goes without saying that the function does not evaluate the plausibility of a metrical representation.

#grid(
  columns: (1fr, 1fr),
  [#align(center + bottom)[
#figure(
  caption: [`#foot("pot.'ta")`],
  foot("pot.'ta", scale: 0.9)
) <fig-ft5>
  ]],
  [#align(center + bottom)[
#figure(
  caption: [`#foot-mora("'pot.ta", coda: true)`],
  foot-mora("'pot.ta", coda: true, scale: 0.9)
) <fig-ft6>
]]
)


Extreme cases are important to test how adaptable the function is when it comes to line crossings, a key problem in prosodic representations. When a head domain is at an edge of a long string, it is challenging to avoid crossings. As can be seen in @fig-ft7, the height of $Sigma$ is proportional to the width of the representation to avoid superposition of lines.


#figure(
  caption: [An extreme case],
foot("'xa.xa.xa.xa.xa.xa.xa.xa.xa.xa.xa.xa", scale: 0.7)
)<fig-ft7>


== Prosodic words <sec-pwd>

Finally, we arrive at prosodic words (PWd), which bring together syllables and feet. This is where the user has more options, given the metrical parameters involved. Parentheses `()` are used to define feet, which means that any syllable _outside_ the foot will be linked directly to the PWd. Next, an apostrophe `'` symbolizing stress (both primary _and_ secondary) is used to indicate the head of each foot. Finally, the argument `foot: "R"` or `foot: "L"` is used to determine which foot in the PWd contains the primary stress in the word (in cases where more than one foot is present in a given PWd).

#grid(
  columns: (1fr, 1fr),
  rows: 2,
  inset: 2em,
  [#align(center + bottom)[
#figure(
  caption: [`#foot("('po.Ra).ma")`],
  word("('po.Ra).ma", scale: 0.9)
) <fig-wd1>
  ]],
  [#align(center + bottom)[
#figure(
  caption: [`#foot-mora("('po.Ra).ma")`],
  word-mora("('po.Ra).ma", coda: true, scale: 0.9)
) <fig-wd2>
]],
[#align(center + bottom)[
  #figure(
  caption: [When `foot: "L"` (default)],
  word-mora("('po.Ra).('ma.pa)", foot: "L", scale: 0.9)
) <fig-wd4>
  ]],
  [#align(center + bottom)[
#figure(
  caption: [When `foot: "R"`],
  word("('po.Ra).('ma.pa)", foot: "R", scale: 0.9)
) <fig-wd3>
]]
)

=== Extreme scenarios

It is worth noting that _all_ lines are straight in the prosody module (this is by design), so curved lines are not a possibility. Consequently, in extreme scenarios, e.g., where an unfooted syllable is far away from the head foot of a given PWd, the height of the representation will be proportional. This will inevitably create tall figures, as already mentioned --- see @fig-extreme.

#figure(
  caption: [Unfooted syllable far away from head foot.],
  word("xa.(xa.xa)(xa.xa)(xa.xa)(xa.xa)", scale: 0.8)
) <fig-extreme>

= SPE

Rewrite rules can be very complex, and an excellent package already exists to deal with their complexity in Typst (#link("https://typst.app/universe/package/linphon")[`linphon`]). The problem is that too many degrees of freedom exist in SPE-like representations, not to mention the variation across scholars when it comes to symbols, brackets, etc. For that reason, Phonokit only has two primitive functions to help create feature matrices, which in turn can be combined to form SPE-style rules @chomsky1968spe

The first function is `#feat-matrix()`, shown in @feat-matrix. It simply outputs the maximal feature matrix for a given phoneme (with the option for 0 values if `all: true`). This can be useful in introductory courses, where students are introduced to the notion of distinctive features. The function does not produce _minimal_ matrices, but it can be used in sequence to represent matrices for a given word, for example --- see @fig-max-feat. The user is free to adjust the inventory of features and their values, since there's variation in the literature. The function in question is based on the features in @hayes2009introductory.


#figure(
  gap: 1em,
  caption: [Generating matrices for the phonemes in "patchy", shown in @fig-max-feat],
  supplement: "Code example",
  kind: "code",
  `#feat-matrix("p") #feat-matrix("\\ae") #feat-matrix("\\t tS") #feat-matrix("i")`
) <feat-matrix>


#figure(gap: 2em,
// placement: auto,
caption: [Matrices for the phonemes in the word "patchy"],
[#feat-matrix("p") #feat-matrix("\\ae") #feat-matrix("\\t tS") #feat-matrix("i")]
) <fig-max-feat>

Next, the function `#feat()` creates a matrix given a set of features. This is the function used in a rewrite rule, for example. The assimilation rule in @fig-spe is achieved with the code shown in @fig-spe-code --- notice that #sym.alpha notation requires a specific syntax, i.e., `sym.X + "feat"` or `sym.X + [#smallcaps("feat")]` if you prefer to use small caps. A helper function, `#blank()`, adds a long underline for the context of application in the rule. Likewise, `#ar` adds an arrow using New Computer Modern (other arrows are available, such as `#al` #al, `#au` #au, `#ad` #ad, `#alr` #alr, `#asr` #asr).

#figure(
  caption: [Nasal place assimilation using `#feat()`], 
  supplement: "Code example",
  kind: "code",
```typst
[#feat("+son", "–approx") #ar #feat(sym.alpha + [#smallcaps("place")]) / #blank()\]#sub[#sym.sigma] #feat("–son", "–cont", "–del rel", sym.alpha + [#smallcaps("place")])]
```
) <fig-spe-code>

#figure(
// placement: auto,
caption: [A nasal place assimilation rule],
[#feat("+son", "–approx") #ar #feat(sym.alpha + [#smallcaps("place")]) / #blank()\]#sub[#sym.sigma] #feat("–son", "–cont", "–del rel", sym.alpha + [#smallcaps("place")])]
) <fig-spe>



= Optimality theory

Unlike SPE rules, tableaux in optimality theory (OT; #cite(<prince1993optimality>, form: "prose")) are more predictable and constrained. As a result, a function can do a bit more. Phonokit includes two constraint-related functions, the first of which is `#tableau()`, shown in @fig-tableau1. The function takes six arguments: `input`, `candidates`, `constraints`, `violations`, `winner`, and `dashed-lines`. The accompanying code shown in @fig-tableau1 provides an example of how each argument works. For example, the `violations` argument requires a nested structure. Likewise, `dashed-lines` requires a comma if you want a given column to have a dashed line. If no dashed lines are needed, you can simply specify `dashed-lines: ()`.

#let tableau1 = tableau(
  input: "kraTa",
  candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
  constraints: ("Max", "Dep", "*Complex"),
  violations: (
    ("", "", "*"),
    ("*!", "", ""),
    ("", "*!", ""),
  ),
  winner: 1,
  dashed-lines: (1,) 
)

#figure(
  caption: [A typical OT tableau],
  supplement: "Tableau",
  kind: "Tableau",
show-example(
  ```typst
#tableau(
  input: "kraTa",
  candidates: ("kra.Ta", "ka.Ta", "ka.ra.Ta"),
  constraints: ("Max", "Dep", "*Complex"),
  violations: (
    ("", "", "*"),
    ("*!", "", ""),
    ("", "*!", ""),
  ),
  winner: 1, // <- Position of winning cand
  dashed-lines: (1,) // <- Note the comma
)

  ```,
  tableau1

)
) <fig-tableau1>

One nice feature of `#tableau()` is that the function automatically shades cells once a fatal violation is entered (`!`). Likewise, it adds the "#finger" symbol for the winner, whose position is extracted from the `winner` argument shown in the accompanying code next to @fig-tableau1.

= Maximum Entropy grammars

Finally, the package goes one step further and produces a MaxEnt tableau @goldwater2003learning @HayesWilson08 with the function `#maxent()`. @fig-tableau2 illustrates a scenario where the data in @fig-tableau1 is variable, i.e., all candidates in question have a non-zero probability of being observed given a specific input $x$. The column $H(y)$ displays the Harmony score of each candidate $y$, calculated as the weighted sum of all constraint violations. Next, the column $e^(-H(y))$ provides the unnormalized probability, which is the exponential of the negated Harmony score (this has also been called the _MaxEnt score_). Finally, the actual predicted probability is shown in column $P(y|x)$, which is obtained by dividing the unnormalized value of a candidate by $Z(x)$ (the sum of all unnormalized scores). The formal equation for this probability is provided in @maxent-prob.

$ P(y|x) = frac(exp^(- sum_(i=1)^n w_i C_i(y, x)), Z(x)) $ <maxent-prob>

The function `#maxent()` calculates $H(y)$, $e^(H(y))$ and $P(y|x)$ automatically given the weights provided. @fig-tableau2 lists the weights for the constraints in use at the top and prints probability bars at the right margin. These can be turned off with `visualize: false` (see @code-maxent), but they are printed by default as this can help students quickly visualize probabilities when many candidates are evaluated.


#figure(
  caption: [A MaxEnt tableau],
  supplement: "Tableau",
  kind: "Tableau",
maxent(
  input: "kraTa",
  candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
  constraints: ("Max", "Dep", "Complex"),
  weights: (2.5, 1.8, 1),
  violations: (
    (0, 0, 1),
    (1, 0, 0),
    (0, 1, 0),
  ),
  visualize: true  // Show probability bars (default)
)
) <fig-tableau2>


In @code-maxent, you can see all the necessary arguments for the function `#maxent()`. Like the function `#tableau()` discussed above, the `violations` argument in `#maxent()` requires a nested structure. Everything else is self-explanatory. As expected, the rows and columns will expand as needed for both constraint-based functions.

#figure(
  caption: [Code to generate a MaxEnt tableau],
  supplement: "Code example",
  kind: "code",
```typst
#maxent(
  input: "kraTa",
  candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
  constraints: ("Max", "Dep", "Complex"),
  weights: (2.5, 1.8, 1),
  violations: (
    (0, 0, 1),
    (1, 0, 0),
    (0, 1, 0),
  ),
  visualize: true  // Show probability bars (default)
)
```
) <code-maxent>


= Future directions

Phonokit is a _very_ young project. As stated above, its main goal is to quickly generate structures that are frequently used by phonologists when typesetting documents for teaching and research. Typst itself is still a new language, and most linguists do not know about it yet (as of 2025). But as the language expands into linguistics, there is potential for significant advances in our workflows: from automated exams to slides and articles, I hope this package will make document preparation quicker and more enjoyable to the phonologists out there.



#pagebreak()
#bibliography("references-typst.bib", title: "References", style: "apa")
#pagebreak()


#counter(heading).update(0)
#set heading(numbering: "A.1.")

= IPA symbol reference


#set text(size: 0.9em)
#figure(
  caption: "TIPA-to-IPA Reference Guide",
  table(
    columns: (auto, auto, auto, auto, auto, auto),
    inset: 5.5pt,
    align: horizon,
    stroke: 0.5pt + luma(200),
    table.header(
      [*Input*], [*Output*], [*Input*], [*Output*], [*Input*], [*Output*]
    ),
    table.hline(stroke: 0.5pt),

    // --- PLOSIVES ---
    table.cell(colspan: 6, align: center)[_Plosives_],
    raw("p"), ipa("p"), raw("b"), ipa("b"), raw("t"), ipa("t"),
    raw("d"), ipa("d"), raw("\\\:t"), ipa("\\:t"), raw("\\\:d"), ipa("\\:d"),
    raw("c"), ipa("c"), raw("k"), ipa("k"), raw("g"), ipa("g"),
    raw("q"), ipa("q"), raw("\\\;G"), ipa("\\;G"), raw("?"), ipa("?"),

    // --- FRICATIVES ---
    table.cell(colspan: 6, align: center)[_Fricatives_],
    raw("f"), ipa("f"), raw("v"), ipa("v"), raw("T"), ipa("T"),
    raw("D"), ipa("D"), raw("s"), ipa("s"), raw("z"), ipa("z"),
    raw("S"), ipa("S"), raw("Z"), ipa("Z"), raw("\\:s"), ipa("\:s"),
    raw("\\\:z"), ipa("\\:z"), raw("C"), ipa("C"), raw("\\\c{c}"), ipa("\\c{c}"),
    raw("x"), ipa("x"), raw("G"), ipa("G"), raw("X"), ipa("X"),
    raw("K"), ipa("K"), raw("Q"), ipa("Q"), raw("h"), ipa("h"),
    raw("H"), ipa("H"), raw("\\\\textbeltl"), ipa("\\textbeltl"), raw("\\\\textlyoghlig"), ipa("\\textlyoghlig"),

        // --- NASALS ---
    table.cell(colspan: 6, align: center)[_Nasals_],
    raw("m"), ipa("m"), raw("M"), ipa("M"), raw("n"), ipa("n"),
    raw("\\\:n"), ipa("\\:n"), raw("\\\\textltailn"), ipa("\\textltailn"), raw("N"), ipa("N"),
    raw("\\\;N"), ipa("\\;N"), [], [], [], [],


    // --- APPROXIMANTS & TRILLS ---
    table.cell(colspan: 6, align: center)[_Approximants & Trills_],
    raw("V"), ipa("V"), raw("\\\*r"), ipa("\\*r"), raw("j"), ipa("j"),
    raw("\\\\textturnmrleg"), ipa("\\textturnmrleg"), raw("l"), ipa("l"), raw("L"), ipa("L"),
    raw("\\\:l"), ipa("\\:l"), raw("\\\;L"), ipa("\\;L"), raw("r"), ipa("r"),
    raw("R"), ipa("R"), raw("\\\:r"), ipa("\\:r"), raw("\\\;R"), ipa("\\;R"),

    table.cell(colspan: 6, align: center)[_Vowels_],
    raw("i"), ipa("i"), raw("I"), ipa("I"), raw("y"), ipa("y"),
    raw("Y"), ipa("Y"), raw("1"), ipa("1"), raw("0"), ipa("0"),
    raw("W"), ipa("W"), raw("u"), ipa("u"), raw("U"), ipa("U"),
    raw("e"), ipa("e"), raw("\\\o"), ipa("\\o"), raw("9"), ipa("9"),
    raw("8"), ipa("8"), raw("7"), ipa("7"), raw("o"), ipa("o"),
    raw("@"), ipa("@"), raw("E"), ipa("E"), raw("\\\oe"), ipa("\oe"),
    raw("3"), ipa("3"), raw("2"), ipa("2"), raw("O"), ipa("O"), 
    raw("\\\ae"), ipa("\ae"), raw("\\\OE"), ipa("\OE"), raw("a"), ipa("a"), 
    raw("5"), ipa("5"), raw("A"), ipa("A"), raw("6"), ipa("6"),

    // --- DIACRITICS & STRESS ---
    table.cell(colspan: 6, align: center)[_Diacritics & Suprasegmentals_],
    raw("'ta"), ipa("'ta"), raw(",ta"), ipa(",ta"), raw("u:"), ipa("u:"),
    raw("\\\~ a"), ipa("\\~ a"), raw("\\\\r i"), ipa("\\r i"), raw("\\\v n"), ipa(" \\v n"),
    raw("t \\\h"), ipa("t \\h"), raw("p \\\*"), ipa("p \\*"), raw("\\\\t ts"), ipa("\\t ts"),
  )
)

= Representing processes

While there are no functions dedicated to phonological processes _per se_, prosodic representations can be linearized and concatenated with arrows, which is frequently enough to show many processes on slides and handouts. @fig-compens shows one simple example generated with @code-compens --- the command `#aR` creates a visually appropriate arrow for this type of figure.

#figure(
  caption: [Compensatory lengthening],
[#mora("kan", coda: true, scale: 0.8) #aR #mora("ka-", coda: true, scale: 0.8) #aR #mora("ka:", scale: 0.8)]
) <fig-compens>


#figure(
  caption: [Transcriptions using `#ipa()`], 
  supplement: "Code example",
  kind: "code",
  ```typst
    #mora("kan", coda: true) #aR #mora("ka-", coda: true) #aR #mora("ka:")
  ```
) <code-compens>


