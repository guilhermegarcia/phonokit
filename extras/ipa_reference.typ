// Complete IPA reference: every TIPA code that #ipa() accepts.
// Generated from ipa.typ, so it never falls behind the package. Rebuild with
//   typst compile --root . extras/ipa_reference.typ extras/ipa_reference.pdf
#import "/ipa.typ": ipa, tone-letter-sets

#let version = toml("/typst.toml").package.version

#set page(paper: "us-letter", margin: (x: 1.5cm, y: 1.6cm), numbering: "1")
#set text(font: "Charis", size: 9pt)
#show raw: set text(size: 8pt)

// --- Reading ipa.typ -------------------------------------------------------

#let source = read("/ipa.typ").split("\n")

// Lines of a dictionary literal: from `let <name> = (` to its closing `)`
#let block-lines(name) = {
  let start = source.position(l => l.trim() == "let " + name + " = (")
  let rest = source.slice(start + 1)
  rest.slice(0, rest.position(l => l.trim() == ")"))
}

// Section headers are comments in capitals: "// CONSONANTS - Plosives"
// → "Consonants — Plosives"; "OTHER " is dropped, a "(...)" note is kept
#let header(line) = {
  let m = line.trim().match(regex("^// ([A-Z][A-Z-]+(?: [A-Z][A-Z-]+)*)(?: - (.+?))?(?: \((.+)\))?$"))
  if m == none { return none }
  let (cat, sub, note) = m.captures
  let cat = cat.replace("OTHER ", "")
  let title = (upper(cat.first()) + lower(cat.slice(1))).replace("Tipa", "TIPA")
  if sub != none { title += " — " + sub }
  if note != none { title += " (" + note + ")" }
  title
}

// `"key": "value",` with the key as written in the source (escapes kept)
#let entry(line) = {
  let m = line.trim().match(regex("^\"((?:[^\"\\\\]|\\\\.)*)\"\\s*:"))
  if m == none { none } else { m.captures.first() }
}

// Groups the entries of a block under their headers
#let sections(name, first: none) = {
  let out = ()
  let current = (title: first, keys: ())
  for line in block-lines(name) {
    let h = header(line)
    if h != none {
      if current.keys.len() > 0 { out.push(current) }
      current = (title: h, keys: ())
    } else {
      let k = entry(line)
      if k != none { current.keys.push(k) }
    }
  }
  if current.keys.len() > 0 { out.push(current) }
  out
}

// The string a source key stands for: "\\:t" → \:t
#let unescape(src) = eval("\"" + src + "\"")

// --- Layout ----------------------------------------------------------------

// The title is a table header: Typst never leaves it alone at the bottom of a
// column, and repeats it when a section continues in the next one
#let section-table(title, rows) = block(below: 1em, table(
  columns: (1fr, auto),
  align: (right + horizon, left + horizon),
  stroke: none,
  inset: (x: 4pt, y: 2.4pt),
  fill: (_, y) => if y > 0 and calc.odd(y) { luma(242) } else { none },
  table.header(table.cell(colspan: 2, align: left, inset: (x: 0pt, bottom: 5pt), text(weight: "bold", size: 9.5pt, title))),
  ..rows.map(((input, output)) => (raw(input), output)).flatten(),
))

// What a key shows as input, and how it is rendered
#let plain-row(src) = {
  let key = unescape(src)
  let shown = if key == "\\s" { [_(space)_] } else { ipa(key) }
  (src, shown)
}
// Example base for each diacritic that goes before the symbol
#let before-row(src) = {
  let base = (("\\\\t": "ts", "\\\\dental": "t", "\\\\r": "d", "\\\\v": "n")).at(src, default: "a")
  (src + " " + base, ipa(unescape(src) + " " + base))
}
#let after-row(src) = ("t " + src, ipa("t " + unescape(src)))

#align(center)[
  #text(size: 15pt, weight: "bold")[Complete IPA Reference] \
  #text(size: 10pt)[All TIPA codes supported by phonokit #version] \
  #text(size: 8pt, fill: luma(90))[Codes are shown as typed inside a Typst string (e.g., `#ipa("\\:t")`). Generated from `ipa.typ`.]
]

#columns(3, gutter: 1.2em, {
  for sec in sections("mappings") {
    section-table(sec.title, sec.keys.map(plain-row))
  }

  let fwd = sections("forward_diacritics", first: "Diacritics before the symbol")
  for sec in fwd {
    section-table(sec.title, sec.keys.map(before-row))
  }
  for sec in sections("backward_diacritics", first: "Diacritics after the symbol") {
    section-table(sec.title, sec.keys.map(after-row))
  }

  // Chao tone letters: every level in each of the four sets
  let kinds = tone-letter-sets.keys()
  for kind in kinds {
    let title = (
      tone: "Tone letters",
      ltone: "Tone letters — Left stem",
      ntone: "Tone letters — Dotted (not IPA)",
      nltone: "Tone letters — Dotted, left stem (not IPA)",
    ).at(kind)
    let rows = ("5", "4", "3", "2", "1").map(l => {
      let src = "\\\\" + kind + "{" + l + "}"
      (src, ipa(unescape(src)))
    })
    if kind == "tone" {
      rows += ("35", "51", "214", "5353").map(l => {
        let src = "\\\\tone{" + l + "}"
        (src, ipa(unescape(src)))
      })
      rows.push(("\\\\tone{214}\\\\tone{214}", ipa("\\tone{214}\\tone{214}")))
    }
    section-table(title, rows)
  }
})
