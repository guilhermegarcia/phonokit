# Phonokit 🪶

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17971032.svg)](https://doi.org/10.5281/zenodo.17971032)

A phonology toolkit for Typst, providing IPA transcription with tipa-style input, prosodic structure visualization, and IPA charts for vowels and consonants.

🚨 **Charis SIL font is needed** for this package to work as intended. If you don't already have this font installed, visit <https://software.sil.org/charis/download/>. In addition, New Computer Modern is used for arrows.

**⚠️ Note:** This repo contains the most up-to-date version of the package (version under development).

## Features

📝 See `vignette.pdf` in this repo for *thorough* demo of the package.

### IPA Module

- **tipa-style input**: Use familiar LaTeX tipa notation instead of hunting for Unicode symbols
- **Comprehensive symbol support**: All IPA consonants, vowels, and other symbols from the tipa chart
- **Combining diacritics**: Nasalized (`\\~`), devoiced (`\\r`), syllabic (`\\v`); the tie (`\\t`) is also available
- **Suprasegmentals**: Primary stress (`'`), secondary stress (`,`), length (`:`)
- **Automatic character splitting**: Type `SE` instead of `S E` for efficiency (spacing is necessary around characters using backslashes)

### IPA Charts Module

- **Vowel charts**: Plot vowels on the IPA vowel trapezoid with accurate positioning
- **Consonant tables**: Display consonants in the pulmonic IPA consonant table
- **Language inventories**: Pre-defined inventories for some languages (English, Spanish, French, German, Italian, Portuguese, Japanese, Russian, Arabic, Mandarin)
- **Custom symbol sets**: Plot any combination of IPA symbols
- **Automatic positioning**: Symbols positioned according to phonetic properties (place, manner, voicing, frontness, height, roundedness)
- **Proper IPA formatting**: Voiceless/voiced pairs, grayed-out impossible articulations, minimal pair bullets for vowels
- **Scalable charts**: Adjust size to fit your document layout (scaling includes text as expected)

### Prosody Module

- **Prosodic structure visualization**: Draw syllable structures with onset, nucleus, and coda
- **Mora-based representations**: Visualize syllable weight using moraic structure (μ)
- **Flexible foot structure**: Use parentheses to mark explicit foot boundaries and stress mark to identify headedness (iambs, trochees)
- **Stress marking**: Mark stressed syllables with apostrophe `'`
- **Flexible alignment**: Left or right alignment for prosodic word heads

### Optimality Theory Module

- **OT tableaux**: Create publication-ready Optimality Theory tableaux with automatic formatting
- **Violation marking**: Use `*` for violations and `!` for fatal violations
- **Automatic shading**: Cells are automatically grayed out after fatal violations
- **Winner indication**: Optimal candidates marked with ☞ (pointing finger)
- **Constraint ranking**: Display ranked constraints with optional dashed lines for ties
- **IPA support**: Input and candidate forms can use tipa-style IPA notation

### Maximum Entropy Module

- **MaxEnt tableaux**: Generate Maximum Entropy grammar tableaux with probability calculations
- **Automatic calculations**: Computes harmony scores H(x), unnormalized probabilities P*(x), and normalized probabilities P(x)
- **Visual probability bars**: Optional graphical representation of candidate probabilities
- **Weighted constraints**: Supports continuous constraint weights
- **IPA support**: Input and candidate forms can use tipa-style IPA notation

### Extras

- **Feature matrices**: Create SPE-style phonological feature matrices
- **Sonority profiles**: Visualize strings of phonemes based on their sonority
- **Flexible input**: Accept features as separate arguments or comma-separated strings
- **Proper formatting**: Displays features in vertical brackets with appropriate spacing

## Installation

### Package Repository

- `http://github.com/guilhermegarcia/phonokit`

### Package website

For the most up-to-date information about the package, vignettes and demos, visit <https://gdgarcia.ca/phonokit>.

## Usage

### IPA Transcription

```typst
// Basic transcription
#ipa("'sIRi")  // → ˈsɪɾi

// With nasalization
#ipa("\\~ E")  // → ɛ̃

// With devoicing
#ipa("\\r z")  // → z̥

// Syllabic segments 
#ipa("\\v n")  // → n̩

// Affricates
#ipa("\\t ts")  // → t͡s

// Complex example with multiple features
#ipa("'sIn,t \\ae ks")  // → ˈsɪnˌtæks
```

#### `tipa` Notation Quick Reference

**Single-character codes** (no space needed):

- Common vowels: `i I e E a A o O u U @`
- Common consonants: `p b t d k g f v s z S Z m n N l r`

**Multi-character codes**

- `\\textltailn` → ɲ
- `\\ae` → æ
- See [`tipa` chart](https://gdgarcia.ca/typst/tipachart.pdf) for complete list

**Diacritics currently supported**:

- Stress: `'` (primary), `,` (secondary)
- Length: `:` (place after segment)
- Liaison: `\\t` (place before segment)
- Devoicing: `\\r` (place before segment)
- Syllabicity: `\\v` (place before segment)
- Aspiration: `\\h` (place after segment)
- Nasal: `\\~` (place before segment)
- C cedilla: `\\c{c}` (of course, simply typing `ç` is easier depending on your keyboard layout)
- Unreleased: `\\*` (place after segment)

**Spacing**:

- Empty space: `\\s` (important if you want to transcribe sentences)

**Important:** Anything that has `\\` must not have adjacent characters:

- `\\~ a` is correct for *ã*; `\\~a` is **not** correct
- `k \\ae t` is correct for *cat*; `k\\aet` is **not** correct
- `[ \\ae t]` is correct for *at*; `[\\ae t]` is **not** correct
- `\\ae t` is correct for *at*; `\\aet` is **not** correct

### IPA Charts

Phonokit provides functions for visualizing IPA vowel and consonant inventories with proper phonetic positioning.

#### Vowel Charts

```typst
// Plot English vowel inventory
#vowels("english")

// Plot specific vowels using IPA notation
#vowels("aeiou")
#vowels("i e E a o O u")  // Using tipa-style notation

// Plot French vowels with custom scale
#vowels("french", scale: 0.5)

// All available vowels
#vowels("all")
```

**Note:** The `vowels()` function now accepts tipa-style IPA input. Diacritics and non-vowel symbols will be automatically ignored during plotting.

**Available vowel language inventories:** `all`, `english`, `spanish`, `french`, `german`, `italian`, `japanese`, `portuguese`, `russian`, `arabic`, `mandarin`

#### Consonant Tables

```typst
// Plot complete pulmonic consonant chart
#consonants("all")

// Plot English consonant inventory
#consonants("english")

// Plot specific consonants using IPA notation
#consonants("ptk")
#consonants("p t k b d g")  // Using tipa-style notation with spaces
#consonants("T D s z S Z")  // Fricatives using tipa notation

// Include affricates row with language-specific affricates
#consonants("english", affricates: true)  // Shows t͡ʃ, d͡ʒ
#consonants("all", affricates: true)      // Shows all common affricates

// Custom affricates with IPA input
#consonants("t \\t s d \\t z t \\t S d \\t Z", affricates: true)

// Include aspirated consonants (phonemic aspiration)
#consonants("mandarin", affricates: true, aspirated: true)  // Shows pʰ, tʰ, kʰ and tsʰ, ʈʂʰ, tɕʰ
#consonants("all", aspirated: true)  // Shows all aspirated plosives

// Plot Spanish consonants with custom scale
#consonants("spanish", scale: 0.6)
```

**Notes:**

- The `consonants()` function now accepts tipa-style IPA input
- Use `affricates: true` to show a dedicated affricate row (appears after fricatives)
  - Affricates are displayed **without tie bars** (e.g., tʃ instead of t͡ʃ) since the row label makes it clear
  - `"all"` with affricates shows: pf, bv (labiodental), ts, dz (alveolar), tʃ, dʒ (postalveolar), ʈʂ, ɖʐ (retroflex)
  - `"english"` with affricates shows: tʃ, dʒ
  - `"german"` with affricates shows: pf, ts
  - `"japanese"` with affricates shows: ts, tɕ, dʑ (alveolo-palatal)
  - `"mandarin"` with affricates shows: ts, ʈʂ, tɕ
  - Custom input: affricates are extracted from your IPA string (with or without tie bars)
- Use `aspirated: true` to show aspirated consonant rows (for languages with phonemic aspiration)
  - Adds "Plosive (aspirated)" row after "Plosive" with symbols like pʰ, tʰ, kʰ
  - When combined with `affricates: true`, also adds "Affricate (aspirated)" row with symbols like tsʰ, tʃʰ
  - `"mandarin"` with aspirated shows: pʰ, tʰ, kʰ (plosives) and tsʰ, ʈʂʰ, tɕʰ (affricates)
  - `"all"` with aspirated shows: pʰ, tʰ, ʈʰ, cʰ, kʰ, qʰ (all aspirated plosives)
- /w/ (labiovelar approximant) appears in both bilabial and velar columns when /ɰ/ (velar approximant) is not present; otherwise only under bilabial
- Diacritics and non-consonant symbols are automatically ignored during plotting

**Available consonant language inventories:** `all`, `english`, `spanish`, `french`, `german`, `italian`, `japanese`, `mandarin`, `portuguese`, `russian`, `arabic`

**Chart features:**

- Vowels positioned by frontness, height, and roundedness on trapezoid
- Consonants organized by place and manner of articulation
- Voiceless consonants on left, voiced on right in each cell
- Impossible articulations (e.g., pharyngeal nasals) automatically grayed out
- Minimal pair bullets for rounded/unrounded vowel pairs
- Default scale of 0.7 fits portrait pages; adjustable with `scale` parameter

### Prosodic Structures

Phonokit provides three functions for visualizing different levels of prosodic structure. The functions `syllable()`, `foot()` and `word()` below also have a `scale` argument (float) for adjusting the size of the resulting prosodic tree. Crucially, the scaling includes the tree, the text and the thickness of the lines in the tree. Furthermore, the length of each line dynamically adapts to the complexity of the representation, which results in a visually balanced figure.

#### Syllable Level

```typst
// Visualize a single syllable's internal structure (σ)
#syllable("man")
#syllable("'to") // stress symbol makes no difference here
```

#### Mora Level

```typst
// Visualize syllable weight using moras (μ)
#mora("ka")  // Light syllable (CV) = 1 mora
#mora("kan") // Heavy syllable (CVN) = 2 moras (coda doesn't count by default)
#mora("kan", coda: true) // Heavy syllable where coda contributes to weight
#mora("kaa") // Heavy syllable (CVV) = 2 moras
```

#### Foot Level

```typst
// Visualize foot (Σ) and syllable (σ) levels
#foot("man.'tal")
#foot("'man.tal")
```

#### Word Level

```typst
// Visualize prosodic word (PWd), foot (Σ), and syllable (σ) levels
#word("(ma.'va).ro")  // One binary iamb; one footless syllable

// Right-aligned prosodic word (default)
#word("ma.('va.ro)")  // One trochee; one footless syllable

// Disyllabic word
#word("('ka.va)")

// A dactyl
#word("('ka.va.mi)")

// Multiple feet, where foot = main foot/stress
#word("('ka.ta)('vas.lo)", foot: "L") 
```

**Prosody notation:**

- `.` separates syllables
- `'` before a syllable marks it as stressed (e.g., `'va`)
- `()` marks foot boundaries (used in `#word()`)
- Characters within syllables are automatically parsed into onset, nucleus, and coda
- Geminates are automatically detected for `#foot()` and `#word()`
- For long vowels, use `vv` instead of using the length diacritic `:`

### SPE Feature Matrices

Create SPE-style phonological feature matrices:

```typst
// Features as separate arguments
#feat("+consonantal", "-sonorant", "+voice")

// Features as comma-separated string
#feat("+cons,-son,+voice,-cont,+ant")

// Use in inline text
The segment #feat("+syl,-cons,+high,-back") represents /i/.
```

### Distinctive Feature Matrices

Display complete distinctive feature specifications for IPA segments based on Hayes (2009):

```typst
// Display feature matrix for a consonant
#feat-matrix("p")  // Shows all specified features for /p/

// Display feature matrix for a vowel
#feat-matrix("i")  // Shows features for /i/

// Using tipa-style notation
#feat-matrix("t \\t s")  // Feature matrix for affricate /t͡s/

// Show all features including unspecified (0) values
#feat-matrix("k", all: true)

// Use in comparative analysis
Comparing #feat-matrix("p") and #feat-matrix("b") shows they differ only in [voice].
```

**Features included:**

- **Consonants**: consonantal, sonorant, continuant, delayed release, approximant, tap, trill, nasal, voice, spread glottis, constricted glottis, labial, round, labiodental, coronal, anterior, distributed, strident, lateral, dorsal, high, low, front, back, tense
- **Vowels**: syllabic, consonantal, sonorant, continuant, voice, high, low, tense, front, back, round

**Available segments:** All IPA consonants and vowels from Hayes (2009) Introductory Phonology, including single place articulations, complex segments, and all standard vowels.

### Optimality Theory Tableaux

Create OT tableaux with automatic violation marking and shading:

```typst
// Basic OT tableau
// With IPA input and dashed constraint boundaries
#tableau(
  input: "kaesa",
  candidates: ("kaesa", "ke:sa", "kesa"),
  constraints: ("Max-μ", "Dep-μ", "*Complex"),
  violations: (
    ("", "", "*!"),
    ("", "*!", ""),
    ("*!", "", ""),
  ),
  winner: 1,
  dashed-lines: (1, 2)  // Show dashed line after constraints 1 and 2
)
```

### Maximum Entropy Grammar

Create MaxEnt tableaux with probability calculations:

```typst
// MaxEnt tableau with probability visualization
#maxent(
  input: "input",
  candidates: ("cand1", "cand2", "cand3"),
  constraints: ("Cons-A", "Cons-B"),
  weights: (2.5, 1.8),
  violations: (
    (0, 1),  // cand1: 0 violations of A, 1 of B
    (1, 0),  // cand2: 1 violation of A, 0 of B
    (1, 1),  // cand3: 1 violation of A, 1 of B
  ),
  visualize: true  // Show probability bars (default)
)

// Without visualization bars
#maxent(
  input: "kaesa",
  candidates: ("kaesa", "ke:sa"),
  constraints: ("Max-μ", "Dep-μ"),
  weights: (3.2, 1.5),
  violations: ((0, 0), (0, 1)),
  visualize: false
)
```

## License

MIT

## Author

**Guilherme D. Garcia** \
Email: <guilherme.garcia@lli.ulaval.ca>

## Citation

If you use this software in your research, please cite it using the metadata from the `CITATION.cff` file or click the "Cite this repository" button in the GitHub sidebar.

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.
