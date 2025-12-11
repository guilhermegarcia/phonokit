#let ipa(input) = {
  // Define TIPA to IPA mappings
  let mappings = (
    // CONSONANTS - Plosives
    "p": "p", "b": "b", "t": "t", "d": "d",
    "\\:t": "ʈ", "\\:d": "ɖ",
    "\\textbardotlessj": "ɟ", "c": "c",
    "k": "k", "g": "ɡ",
    "q": "q", "\\;G": "ɢ",
    "?": "ʔ",

    // CONSONANTS - Nasals
    "m": "m", "M": "ɱ", "n": "n",
    "\\:n": "ɳ", "\\textltailn": "ɲ",
    "N": "ŋ", "\\;N": "ɴ",

    // CONSONANTS - Trills
    "\\;B": "ʙ", "r": "r", "\\;R": "ʀ",

    // CONSONANTS - Tap or Flap
    "R": "ɾ", "\\:r": "ɽ",

    // CONSONANTS - Fricatives
    "f": "f", "v": "v",
    "F": "ɸ", "B": "β",
    "T": "θ", "D": "ð",
    "s": "s", "z": "z",
    "S": "ʃ", "Z": "ʒ",
    "\\:s": "ʂ", "\\:z": "ʐ",
    "\\c{c}": "ç", "J": "ʝ",
    "x": "x", "G": "ɣ",
    "X": "χ", "K": "ʁ",
    "\\textcrh": "ħ", "Q": "ʁ",
    "h": "h", "H": "ɦ",

    // CONSONANTS - Lateral Fricatives
    "\\textbeltl": "ɬ", "\\textlyoghlig": "ɮ",

    // CONSONANTS - Approximants
    "V": "ʋ", "\\*r": "ɹ", "j": "j",
    "\\textturnmrleg": "ɰ", "\\:R": "ɻ",

    // CONSONANTS - Lateral Approximants
    "l": "l", "\\:l": "ɭ", "L": "ʎ", "\\;L": "ʟ",

    // OTHER CONSONANTS - Clicks
    "\\!o": "ʘ", "\\textdoublebarpipe": "ǂ",
    "||": "ǁ",

    // OTHER CONSONANTS - Other
    "\\textbarglotstop": "ʡ",

    // OTHER CONSONANTS - Implosives
    "\\!b": "ɓ", "\\!d": "ɗ", "\\!j": "ʄ",
    "\\!g": "ɠ", "\\!G": "ʛ",

    // OTHER CONSONANTS - Additional Fricatives
    "\\*w": "ʍ", "\\texththeng": "ɧ", "C": "ç",
    "\\;H": "ʜ", "\\textctz": "ʦ",
    "\\textbarrevglotstop": "ʢ",

    // OTHER CONSONANTS - Approximant/Flap
    "4": "ɤ", "\\textturnlonglegr": "ɺ",

    // VOWELS - Close
    "i": "i", "I": "ɪ", "y": "y", "Y": "ʏ",
    "1": "ɨ", "0": "ʉ", "W": "ɯ", "u": "u", "U": "ʊ",

    // VOWELS - Close-mid/Mid
    "e": "e", "\\o": "ø", "9": "ɘ", "8": "ɵ",
    "7": "ɤ", "o": "o",

    // VOWELS - Mid
    "@": "ə", "\\textschwa": "ə",

    // VOWELS - Open-mid
    "E": "ɛ", "\\oe": "œ", "3": "ɜ",
    "\\textcloseepsilon": "ɞ", "2": "ʌ", "O": "ɔ",

    // VOWELS - Near-open/Open
    "\\ae": "æ", "\\OE": "ɶ",
    "a": "a", "5": "ɐ", "A": "ɑ", "6": "ɒ",
    "\\schwar": "ɚ", "\\epsilonr": "ɝ",

    // SUPRASEGMENTALS
    "'": "ˈ",   // primary stress
    ",": "ˌ",   // secondary stress
    ":": "ː",   // length mark

    // SPACING
    "\\s": " ",  // space
  )

  // Define combining diacritics
  let diacritics = (
    "\\~": "̃",  // combining tilde (nasalization)
    "\\r": "̥",  // combining ring below (devoicing)
    "\\v": "̩",  // combining vertical line below (voicing)
    "\\*": "̚",  // combining left angle above (unreleased)
    "\\h": "ʰ",  // modifier letter small h (aspirated)
  )

  // Split by spaces and process each token
  let tokens = input.split(" ")
  let result = ""
  let i = 0

  while i < tokens.len() {
    let token = tokens.at(i)

    // Check if this token is a diacritic
    if token in diacritics {
      // Just append it - combining diacritics apply to previous character
      result += diacritics.at(token)
    } else if token.contains("\\") {
      // Backslash command
      if token in mappings {
        result += mappings.at(token)
      } else {
        result += token
      }
    } else {
      // No backslash: split into individual characters
      for char in token.clusters() {
        if char in mappings {
          result += mappings.at(char)
        } else {
          result += char
        }
      }
    }

    i += 1
  }

  text(font: "Charis SIL", result)
}
