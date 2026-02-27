// Inuktitut Syllabics conversion tables
// Maps Roman orthography → Unicode Canadian Aboriginal Syllabics (U+1400–U+167F)
//
// Three dialects:
//   "nunavut"      — standard Nunavut Inuktitut (3-vowel system: i, u, a)
//   "nunavik"      — Nunavik/Quebec (adds 4th AI-diphthong orientation column)
//   "north-baffin" — North Baffin/Nattilingmiutut (adds LH series for /ɬ/)
//
// Each dialect entry has two keys:
//   "cv"     — maps "consonant+vowel" (and bare vowels) → syllabic character
//   "finals" — maps consonant → raised final character (syllable-final position)
//
// Long vowels (aa, ii, uu) are precomposed code points, not combining sequences.
// Geminates are written final + next CV syllable (e.g. kku = ᒃᑯ).
//
// Sources: Wikipedia/Inuktitut syllabics, Unicode UCAS block (U+1400–U+167F),
//          r12a.github.io/scripts/cans/ike.html
// To be verified by Richard Compton (UQAM) before production use.

// ─── Base CV table (shared by all three dialects) ────────────────────────────

#let _base-cv = (
  // Standalone vowels
  "i":   "ᐃ",  // U+1403
  "ii":  "ᐄ",  // U+1404
  "u":   "ᐅ",  // U+1405
  "uu":  "ᐆ",  // U+1406
  "a":   "ᐊ",  // U+140A
  "aa":  "ᐋ",  // U+140B

  // P series
  "pi":  "ᐱ",  // U+1431
  "pii": "ᐲ",  // U+1432
  "pu":  "ᐳ",  // U+1433
  "puu": "ᐴ",  // U+1434
  "pa":  "ᐸ",  // U+1438
  "paa": "ᐹ",  // U+1439

  // T series
  "ti":  "ᑎ",  // U+144E
  "tii": "ᑏ",  // U+144F
  "tu":  "ᑐ",  // U+1450
  "tuu": "ᑑ",  // U+1451
  "ta":  "ᑕ",  // U+1455
  "taa": "ᑖ",  // U+1456

  // K series
  "ki":  "ᑭ",  // U+146D
  "kii": "ᑮ",  // U+146E
  "ku":  "ᑯ",  // U+146F
  "kuu": "ᑰ",  // U+1470
  "ka":  "ᑲ",  // U+1472
  "kaa": "ᑳ",  // U+1473

  // G series (/ɣ/ or /g/ depending on dialect)
  "gi":  "ᒋ",  // U+148B
  "gii": "ᒌ",  // U+148C
  "gu":  "ᒍ",  // U+148D
  "guu": "ᒎ",  // U+148E
  "ga":  "ᒐ",  // U+1490
  "gaa": "ᒑ",  // U+1491

  // M series
  "mi":  "ᒥ",  // U+14A5
  "mii": "ᒦ",  // U+14A6
  "mu":  "ᒧ",  // U+14A7
  "muu": "ᒨ",  // U+14A8
  "ma":  "ᒪ",  // U+14AA
  "maa": "ᒫ",  // U+14AB

  // N series
  "ni":  "ᓂ",  // U+14C2
  "nii": "ᓃ",  // U+14C3
  "nu":  "ᓄ",  // U+14C4
  "nuu": "ᓅ",  // U+14C5
  "na":  "ᓇ",  // U+14C7
  "naa": "ᓈ",  // U+14C8

  // S series (pronounced /h/ in western dialects)
  "si":  "ᓯ",  // U+14EF
  "sii": "ᓰ",  // U+14F0
  "su":  "ᓱ",  // U+14F1
  "suu": "ᓲ",  // U+14F2
  "sa":  "ᓴ",  // U+14F4
  "saa": "ᓵ",  // U+14F5

  // L series
  "li":  "ᓕ",  // U+14D5
  "lii": "ᓖ",  // U+14D6
  "lu":  "ᓗ",  // U+14D7
  "luu": "ᓘ",  // U+14D8
  "la":  "ᓚ",  // U+14DA
  "laa": "ᓛ",  // U+14DB

  // J series (Unicode names use "Y")
  "ji":  "ᔨ",  // U+1528
  "jii": "ᔩ",  // U+1529
  "ju":  "ᔪ",  // U+152A
  "juu": "ᔫ",  // U+152B
  "ja":  "ᔭ",  // U+152D
  "jaa": "ᔮ",  // U+152E

  // V series (Unicode names use "F")
  "vi":  "ᕕ",  // U+1555
  "vii": "ᕖ",  // U+1556
  "vu":  "ᕗ",  // U+1557
  "vuu": "ᕘ",  // U+1558
  "va":  "ᕙ",  // U+1559
  "vaa": "ᕚ",  // U+155A

  // R series
  "ri":  "ᕆ",  // U+1546
  "rii": "ᕇ",  // U+1547
  "ru":  "ᕈ",  // U+1548
  "ruu": "ᕉ",  // U+1549
  "ra":  "ᕋ",  // U+154B
  "raa": "ᕌ",  // U+154C

  // Q series (uvular stop)
  "qi":  "ᕿ",  // U+157F
  "qii": "ᖀ",  // U+1580
  "qu":  "ᖁ",  // U+1581
  "quu": "ᖂ",  // U+1582
  "qa":  "ᖃ",  // U+1583
  "qaa": "ᖄ",  // U+1584

  // NG series (velar nasal /ŋ/)
  "ngi":  "ᖏ",  // U+158F
  "ngii": "ᖐ",  // U+1590
  "ngu":  "ᖑ",  // U+1591
  "nguu": "ᖒ",  // U+1592
  "nga":  "ᖓ",  // U+1593
  "ngaa": "ᖔ",  // U+1594

  // NNG series (geminate /ŋŋ/ — distinct from ng+CV)
  "nngi":  "ᙱ",  // U+1671
  "nngii": "ᙲ",  // U+1672
  "nngu":  "ᙳ",  // U+1673
  "nnguu": "ᙴ",  // U+1674
  "nnga":  "ᙵ",  // U+1675
  "nngaa": "ᙶ",  // U+1676
)

// ─── Finals (syllable-final consonants) ──────────────────────────────────────
// Same across all three dialects (LH final added for north-baffin below)

#let _base-finals = (
  "p":   "ᑉ",  // U+1449
  "t":   "ᑦ",  // U+1466
  "k":   "ᒃ",  // U+1483
  "g":   "ᒡ",  // U+14A1
  "m":   "ᒻ",  // U+14BB
  "n":   "ᓐ",  // U+14D0
  "s":   "ᔅ",  // U+1505
  "l":   "ᓪ",  // U+14EA
  "j":   "ᔾ",  // U+153E
  "v":   "ᕝ",  // U+155D
  "r":   "ᕐ",  // U+1550
  "q":   "ᖅ",  // U+1585
  "ng":  "ᖕ",  // U+1595
  "nng": "ᖖ",  // U+1596 — geminate NG final
)

// ─── Nunavik AI-diphthong column ──────────────────────────────────────────────
// The fourth orientation (pointing down), reintroduced by Makivik Corporation.
// In Nunavut, /ai/ is instead written as a-form + standalone ᐃ (i).

#let _nunavik-ai = (
  "ai":   "ᐁ",  // U+1401  standalone AI
  "pai":  "ᐯ",  // U+142F
  "tai":  "ᑌ",  // U+144C
  "kai":  "ᑫ",  // U+146B
  "gai":  "ᒉ",  // U+1489
  "mai":  "ᒣ",  // U+14A3
  "nai":  "ᓀ",  // U+14C0
  "sai":  "ᓭ",  // U+14ED
  "lai":  "ᓓ",  // U+14D3
  "jai":  "ᔦ",  // U+1526
  "vai":  "ᕓ",  // U+1553
  "rai":  "ᕃ",  // U+1543
  "qai":  "ᙯ",  // U+166F
  "ngai": "ᙰ",  // U+1670
)

// ─── Nunavik H series (distinct /h/ phoneme — separate from S/H alternation) ──
// In Nunavut, /h/ = /s/ (same characters, phonetic variation only).
// In Nunavik, /h/ is a distinct phoneme with its own syllabic series.
// Unicode names these "NUNAVIK H*"; the "E" slot (row 4) = AI diphthong form.

#let _nunavik-h = (
  "hai": "ᕴ",  // U+1574  NUNAVIK HE (= HAI in Inuktitut vowel naming)
  "hi":  "ᕵ",  // U+1575  NUNAVIK HI
  "hii": "ᕶ",  // U+1576  NUNAVIK HII
  "hu":  "ᕷ",  // U+1577  NUNAVIK HO  (= HU)
  "huu": "ᕸ",  // U+1578  NUNAVIK HOO (= HUU)
  "ha":  "ᕹ",  // U+1579  NUNAVIK HA
  "haa": "ᕺ",  // U+157A  NUNAVIK HAA
)

#let _nunavik-h-final = (
  "h": "ᕻ",  // U+157B  NUNAVIK H (final)
)

// Note: U+157C = CANADIAN SYLLABICS NUNAVUT H (a literal latin capital H glyph)
// used in Nunavut for borrowed words with surface /h/. Not yet implemented.

// ─── LH series (voiceless lateral fricative /ɬ/, North Baffin) ───────────────

#let _lh-cv = (
  "lhi":  "ᖠ",  // U+15A0
  "lhii": "ᖡ",  // U+15A1
  "lhu":  "ᖢ",  // U+15A2
  "lhuu": "ᖣ",  // U+15A3
  "lha":  "ᖤ",  // U+15A4
  "lhaa": "ᖥ",  // U+15A5
)

#let _lh-final = (
  "lh": "ᖦ",   // U+15A6
)

// ─── Assembled dialect tables ─────────────────────────────────────────────────

#let syllabics-data = (
  "nunavut": (
    cv:     _base-cv,
    finals: _base-finals,
  ),
  "nunavik": (
    cv:     _base-cv + _nunavik-ai + _nunavik-h,
    finals: _base-finals + _nunavik-h-final,
  ),
  "north-baffin": (
    cv:     _base-cv + _lh-cv,
    finals: _base-finals + _lh-final,
  ),
)
