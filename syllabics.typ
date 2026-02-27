// Inuktitut Syllabics functions for Phonokit
//
// #syllabics(input, dialect: "nunavut")
//   Roman orthography → Unicode Canadian Aboriginal Syllabics
//
// #roman(input, dialect: "nunavut")
//   Unicode Canadian Aboriginal Syllabics → Roman orthography
//
// Supported dialects: "nunavut" (default), "nunavik", "north-baffin"
//
// Font: Noto Sans Canadian Aboriginal (free, Google Fonts)
//       Install before compiling: https://fonts.google.com/noto/specimen/Noto+Sans+Canadian+Aboriginal
//
// Note: font handling will be integrated with phonokit-font state (_config.typ)
//       in a future version. For now it defaults to Noto Sans Canadian Aboriginal
//       (free, Google Fonts). Falls back to Euphemia UCAS (macOS system font).

#import "syllabics-tables.typ": syllabics-data

// ─── Consonant priority lists (longest match first) ──────────────────────────
// The parser tries these in order to avoid, e.g., matching "n" before "ng" or "nng".

#let _cons3 = ("nng",)
#let _cons2 = ("ng", "lh")
#let _cons1 = ("p", "t", "k", "g", "q", "s", "h", "l", "j", "v", "m", "n", "r")

// ─── Core conversion: Roman → Syllabics ──────────────────────────────────────

#let roman-to-syllabics(input, dialect: "nunavut") = {
  let tables = syllabics-data.at(dialect)
  let cv      = tables.at("cv")
  let finals  = tables.at("finals")

  // ── Pre-normalization ──────────────────────────────────────────────────────
  // Lowercase first: Inuktitut Roman has no case distinction
  let input = lower(input)

  // qq + vowel → qk + vowel
  // Inuktitut syllabics writes the geminate uvular as q-final + k-series CV,
  // not q-final + q-series CV. E.g. qqi = ᖅᑭ (not ᖅᕿ), qqa = ᖅᑲ (not ᖅᖃ).
  // Replace longest forms first to avoid partial matches.
  let input = input
    .replace("qqii", "qkii")
    .replace("qquu", "qkuu")
    .replace("qqaa", "qkaa")
    .replace("qqi",  "qki")
    .replace("qqu",  "qku")
    .replace("qqa",  "qka")

  // In Nunavut and North Baffin, /h/ and /s/ are phonetic variants → same syllabics.
  // Nunavik has a distinct H series (U+1574–U+157B), so we skip this normalization there.
  let input = if dialect != "nunavik" { input.replace("h", "s") } else { input }

  // Some western dialects (e.g. Kivalliq) write /v/ before /l/ as 'b' — normalize to 'v'.
  let input = input.replace("bl", "vl")

  let chars = input.clusters()
  let n     = chars.len()
  let result = ""
  let i = 0

  while i < n {
    // ── 1. Try to match a consonant (longest match first) ──────────────────
    let cons = ""
    let cons-len = 0

    if i + 2 < n {
      let try3 = chars.slice(i, count: 3).join("")
      if try3 in _cons3 {
        cons = try3
        cons-len = 3
      }
    }
    if cons == "" and i + 1 < n {
      let try2 = chars.slice(i, count: 2).join("")
      if try2 in _cons2 {
        cons = try2
        cons-len = 2
      }
    }
    if cons == "" {
      let try1 = chars.at(i)
      if try1 in _cons1 {
        cons = try1
        cons-len = 1
      }
    }

    let j = i + cons-len  // position after consonant

    // ── 2. Try to match a vowel (longest match first) ──────────────────────
    let vowel = ""
    let vowel-len = 0

    if j + 1 < n {
      let try2 = chars.slice(j, count: 2).join("")
      // Long vowels always; AI diphthong only in nunavik
      if try2 in ("aa", "ii", "uu") or (dialect == "nunavik" and try2 == "ai") {
        vowel = try2
        vowel-len = 2
      }
    }
    if vowel == "" and j < n {
      let try1 = chars.at(j)
      if try1 in ("a", "i", "u") {
        vowel = try1
        vowel-len = 1
      }
    }

    // ── 3. Dispatch ────────────────────────────────────────────────────────
    if cons != "" and vowel != "" {
      // CV syllable
      let key = cons + vowel
      result += cv.at(key, default: "[?" + key + "]")
      i = j + vowel-len
    } else if cons != "" {
      // Syllable-final consonant
      result += finals.at(cons, default: "[?" + cons + "]")
      i = j
    } else if vowel != "" {
      // Standalone vowel (word-initial or after another vowel)
      result += cv.at(vowel, default: "[?" + vowel + "]")
      i = j + vowel-len
    } else {
      // Passthrough: space, punctuation, unknown character
      result += chars.at(i)
      i += 1
    }
  }

  result
}

// ─── Core conversion: Syllabics → Roman ──────────────────────────────────────

#let syllabics-to-roman(input, dialect: "nunavut") = {
  let tables = syllabics-data.at(dialect)
  let cv      = tables.at("cv")
  let finals  = tables.at("finals")

  // Build reverse lookup: Unicode char → Roman string
  let reverse = (:)
  for (roman-key, syll-char) in cv {
    reverse.insert(syll-char, roman-key)
  }
  for (roman-key, syll-char) in finals {
    // Finals might shadow CV entries; prefix with "-" to mark,
    // but since finals are distinct Unicode chars this is safe
    reverse.insert(syll-char, roman-key)
  }

  let result = ""
  for char in input.clusters() {
    result += reverse.at(char, default: char)
  }
  result
}

// ─── Display functions ────────────────────────────────────────────────────────

// syllabics(input) supports {escape} syntax for inline Roman segments:
//   #syllabics("nunavut {Microsoft}-mit")
//   → syllabics for "nunavut" and "-mit", Roman for "Microsoft"
// Anything inside { } is passed through in the document's current font.

#let syllabics(input, dialect: "nunavut") = {
  // Split into alternating syllabics/escaped segments
  let parts = ()
  let current = ""
  let in-escape = false

  for char in input.clusters() {
    if char == "{" and not in-escape {
      if current != "" { parts.push((escaped: false, text: current)) }
      current = ""
      in-escape = true
    } else if char == "}" and in-escape {
      if current != "" { parts.push((escaped: true, text: current)) }
      current = ""
      in-escape = false
    } else {
      current += char
    }
  }
  if current != "" { parts.push((escaped: in-escape, text: current)) }

  // Render: escaped segments use document font; others use syllabics font
  for part in parts {
    if part.escaped {
      part.text
    } else {
      text(font: ("Noto Sans Canadian Aboriginal", "Euphemia UCAS"),
        roman-to-syllabics(part.text, dialect: dialect)
      )
    }
  }
}

// Returns plain text (Roman is already in the document font)
#let roman(input, dialect: "nunavut") = {
  syllabics-to-roman(input, dialect: dialect)
}
