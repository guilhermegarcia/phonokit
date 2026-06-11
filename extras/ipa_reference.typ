#import "phonokit/lib.typ": *
#set page(margin: 1.5cm, columns: 2)

// Logo:
#let kit = text(font: "Charis", fill: blue.darken(5%))[*#emph[k]it*]
#let logo = text(font: "Charis")[*phono*#kit]

#place(top + center, float: true, scope: "parent", block(width: 100%)[
  #align(center, text(size: 16pt, weight: "bold")[Complete IPA Reference])
  #v(0.3em)
  #align(center)[All `tipa` codes supported by #logo]
  #v(1em)
])

#let entry(code, ipa-str) = {
  // Display with \\ prefix for backslash commands
  let display = if code.starts-with("\\") or code.contains(" \\") {
    code.replace("\\", "\\\\")
  } else { code }
  (raw(display), ipa(ipa-str))
}
#let section(title) = (table.cell(colspan: 2, align: center, inset: (top: 8pt, bottom: 4pt))[*_#title _*],)

#align(center)[
  #text(size: 9.5pt, table(
    columns: (auto, auto),
    inset: 5pt,
    align: (right, left),
    stroke: 0.5pt + luma(200),
    fill: (x, _) => if calc.even(x) { rgb("#f0f0f0") } else { none },

    // ===================== CONSONANTS — PLOSIVES =====================
    ..section("Consonants — Plosives"),
    ..entry("p", "p"),
    ..entry("b", "b"),
    ..entry("t", "t"),
    ..entry("d", "d"),
    ..entry("\\:t", "\\:t"),
    ..entry("\\:d", "\\:d"),
    ..entry("\\textbardotlessj", "\\textbardotlessj"),
    ..entry("\\barredj", "\\barredj"),
    ..entry("c", "c"),
    ..entry("k", "k"),
    ..entry("g", "g"),
    ..entry("q", "q"),
    ..entry("\\;G", "\\;G"),
    ..entry("?", "?"),
    ..entry("P", "P"),

    // ===================== CONSONANTS — NASALS =====================
    ..section("Consonants — Nasals"),
    ..entry("m", "m"),
    ..entry("M", "M"),
    ..entry("n", "n"),
    ..entry("\\:n", "\\:n"),
    ..entry("\\textltailn", "\\textltailn"),
    ..entry("N", "N"),
    ..entry("\\;N", "\\;N"),
    ..entry("\\nh", "\\nh"),

    // ===================== CONSONANTS — TRILLS =====================
    ..section("Consonants — Trills"),
    ..entry("\\;B", "\\;B"),
    ..entry("r", "r"),
    ..entry("\\;R", "\\;R"),

    // ===================== CONSONANTS — TAPS & FLAPS =====================
    ..section("Consonants — Taps & Flaps"),
    ..entry("R", "R"),
    ..entry("\\:r", "\\:r"),

    // ===================== CONSONANTS — FRICATIVES =====================
    ..section("Consonants — Fricatives"),
    ..entry("f", "f"),
    ..entry("v", "v"),
    ..entry("F", "F"),
    ..entry("B", "B"),
    ..entry("T", "T"),
    ..entry("D", "D"),
    ..entry("s", "s"),
    ..entry("z", "z"),
    ..entry("S", "S"),
    ..entry("Z", "Z"),
    ..entry("\\:s", "\\:s"),
    ..entry("\\:z", "\\:z"),
    ..entry("\\c{c}", "\\c{c}"),
    ..entry("C", "C"),
    ..entry("J", "J"),
    ..entry("x", "x"),
    ..entry("G", "G"),
    ..entry("X", "X"),
    ..entry("K", "K"),
    ..entry("\\textcrh", "\\textcrh"),
    ..entry("\\barredh", "\\barredh"),
    ..entry("Q", "Q"),
    ..entry("h", "h"),
    ..entry("H", "H"),

    // ===================== CONSONANTS — LATERAL FRICATIVES =====================
    ..section("Consonants — Lateral Fricatives"),
    ..entry("\\textbeltl", "\\textbeltl"),
    ..entry("\\textlyoghlig", "\\textlyoghlig"),
    ..entry("\\l3", "\\l3"),

    // ===================== CONSONANTS — APPROXIMANTS =====================
    ..section("Consonants — Approximants"),
    ..entry("V", "V"),
    ..entry("\\*r", "\\*r"),
    ..entry("j", "j"),
    ..entry("\\textturnmrleg", "\\textturnmrleg"),
    ..entry("\\mw", "\\mw"),
    ..entry("\\:R", "\\:R"),

    // ===================== CONSONANTS — LATERAL APPROXIMANTS =====================
    ..section("Consonants — Lateral Approximants"),
    ..entry("l", "l"),
    ..entry("\\:l", "\\:l"),
    ..entry("L", "L"),
    ..entry("\\;L", "\\;L"),
    ..entry("\\darkl", "\\darkl"),

    // ===================== CONSONANTS — CLICKS =====================
    ..section("Consonants — Clicks"),
    ..entry("\\!o", "\\!o"),
    ..entry("\\textdoublebarpipe", "\\textdoublebarpipe"),
    ..entry("\\doublebarpipe", "\\doublebarpipe"),
    ..entry("||", "||"),

    // ===================== CONSONANTS — IMPLOSIVES =====================
    ..section("Consonants — Implosives"),
    ..entry("\\!b", "\\!b"),
    ..entry("\\!d", "\\!d"),
    ..entry("\\!j", "\\!j"),
    ..entry("\\!g", "\\!g"),
    ..entry("\\!G", "\\!G"),

    // ===================== CONSONANTS — OTHER =====================
    ..section("Consonants — Other"),
    ..entry("\\textbarglotstop", "\\textbarglotstop"),
    ..entry("\\barredP", "\\barredP"),
    ..entry("\\*w", "\\*w"),
    ..entry("\\texththeng", "\\texththeng"),
    ..entry("\\;H", "\\;H"),
    ..entry("\\textctz", "\\textctz"),
    ..entry("\\textbarrevglotstop", "\\textbarrevglotstop"),
    ..entry("\\barrevglotstop", "\\barrevglotstop"),
    ..entry("\\textturnlonglegr", "\\textturnlonglegr"),
    ..entry("\\turnlonglegr", "\\turnlonglegr"),

    // ===================== VOWELS — CLOSE & NEAR-CLOSE =====================
    ..section("Vowels — Close & Near-close"),
    ..entry("i", "i"),
    ..entry("I", "I"),
    ..entry("y", "y"),
    ..entry("Y", "Y"),
    ..entry("1", "1"),
    ..entry("0", "0"),
    ..entry("W", "W"),
    ..entry("u", "u"),
    ..entry("U", "U"),

    // ===================== VOWELS — MID =====================
    ..section("Vowels — Mid"),
    ..entry("e", "e"),
    ..entry("\\o", "\\o"),
    ..entry("9", "9"),
    ..entry("8", "8"),
    ..entry("7", "7"),
    ..entry("o", "o"),
    ..entry("@", "@"),

    // ===================== VOWELS — OPEN-MID & OPEN =====================
    ..section("Vowels — Open-mid & Open"),
    ..entry("E", "E"),
    ..entry("\\oe", "\\oe"),
    ..entry("3", "3"),
    ..entry("\\textcloseepsilon", "\\textcloseepsilon"),
    ..entry("\\closeepsilon", "\\closeepsilon"),
    ..entry("2", "2"),
    ..entry("O", "O"),
    ..entry("\\ae", "\\ae"),
    ..entry("\\OE", "\\OE"),
    ..entry("a", "a"),
    ..entry("5", "5"),
    ..entry("A", "A"),
    ..entry("6", "6"),
    ..entry("\\schwar", "\\schwar"),
    ..entry("\\epsilonr", "\\epsilonr"),

    // ===================== SUPRASEGMENTALS =====================
    ..section("Suprasegmentals"),
    ..entry("'a", "'a"),
    ..entry(",a", ",a"),
    ..entry("a:", "a:"),
    ..entry("\\s", "\\s"),

    // ===================== FORWARD DIACRITICS =====================
    ..section("Forward Diacritics"),
    ..entry("\\~ a", "\\~ a"),
    ..entry("\\r i", "\\r i"),
    ..entry("\\v n", "\\v n"),
    ..entry("\\t ts", "\\t ts"),
    ..entry("\\dental t", "\\dental t"),

    // ===================== BACKWARD DIACRITICS =====================
    ..section("Backward Diacritics"),
    ..entry("p \\*", "p \\*"),
    ..entry("t \\h", "t \\h"),
    ..entry("k \\labial", "k \\labial"),
    ..entry("p \\velar", "p \\velar"),
    ..entry("t \\palatal", "t \\palatal"),
    ..entry("p \\ej", "p \\ej"),

    // ===================== ARCHIPHONEME ESCAPES =====================
    ..section("Archiphoneme Escapes"),
    ..entry("\\A", "\\A"),
    ..entry("\\B", "\\B"),
    ..entry("\\C", "\\C"),
    ..entry("\\D", "\\D"),
    ..entry("\\E", "\\E"),
    ..entry("\\F", "\\F"),
    ..entry("\\G", "\\G"),
    ..entry("\\H", "\\H"),
    ..entry("\\I", "\\I"),
    ..entry("\\J", "\\J"),
    ..entry("\\K", "\\K"),
    ..entry("\\L", "\\L"),
    ..entry("\\M", "\\M"),
    ..entry("\\N", "\\N"),
    ..entry("\\O", "\\O"),
    ..entry("\\P", "\\P"),
    ..entry("\\Q", "\\Q"),
    ..entry("\\R", "\\R"),
    ..entry("\\S", "\\S"),
    ..entry("\\T", "\\T"),
    ..entry("\\U", "\\U"),
    ..entry("\\V", "\\V"),
    ..entry("\\W", "\\W"),
    ..entry("\\X", "\\X"),
    ..entry("\\Y", "\\Y"),
    ..entry("\\Z", "\\Z"),

    // ===================== TIPA LONG-FORM ALTERNATIVES =====================
    ..section("TIPA Long-form Alternatives"),
    // A
    ..entry("\\textturna", "\\textturna"),
    ..entry("\\textscripta", "\\textscripta"),
    ..entry("\\textturnscripta", "\\textturnscripta"),
    ..entry("\\textsca", "\\textsca"),
    ..entry("\\;A", "\\;A"),
    ..entry("\\textturnv", "\\textturnv"),
    // B
    ..entry("\\texthtb", "\\texthtb"),
    ..entry("\\textscb", "\\textscb"),
    ..entry("\\textcrb", "\\textcrb"),
    ..entry("\\textbarb", "\\textbarb"),
    ..entry("\\textbeta", "\\textbeta"),
    ..entry("\\textsoftsign", "\\textsoftsign"),
    ..entry("\\texthardsign", "\\texthardsign"),
    // C
    ..entry("\\textbarc", "\\textbarc"),
    ..entry("\\texthtc", "\\texthtc"),
    ..entry("\\v{c}", "\\v{c}"),
    ..entry("\\textctc", "\\textctc"),
    ..entry("\\textstretchc", "\\textstretchc"),
    // D
    ..entry("\\textcrd", "\\textcrd"),
    ..entry("\\textbard", "\\textbard"),
    ..entry("\\texthtd", "\\texthtd"),
    ..entry("\\textrtaild", "\\textrtaild"),
    ..entry("\\textctd", "\\textctd"),
    ..entry("\\textdzlig", "\\textdzlig"),
    ..entry("\\textdctzlig", "\\textdctzlig"),
    ..entry("\\textdyoghlig", "\\textdyoghlig"),
    ..entry("\\dh", "\\dh"),
    // E
    ..entry("\\textschwa", "\\textschwa"),
    ..entry("\\textrhookschwa", "\\textrhookschwa"),
    ..entry("\\textreve", "\\textreve"),
    ..entry("\\textsce", "\\textsce"),
    ..entry("\\;E", "\\;E"),
    ..entry("\\textepsilon", "\\textepsilon"),
    ..entry("\\textrevepsilon", "\\textrevepsilon"),
    ..entry("\\textrhookrevepsilon", "\\textrhookrevepsilon"),
    ..entry("\\textcloserevepsilon", "\\textcloserevepsilon"),
    // G
    ..entry("\\textg", "\\textg"),
    ..entry("\\textbarg", "\\textbarg"),
    ..entry("\\textcrg", "\\textcrg"),
    ..entry("\\texthtg", "\\texthtg"),
    ..entry("\\textscg", "\\textscg"),
    ..entry("\\texthtscg", "\\texthtscg"),
    ..entry("\\textgamma", "\\textgamma"),
    ..entry("\\textbabygamma", "\\textbabygamma"),
    ..entry("\\textramshorns", "\\textramshorns"),
    // H
    ..entry("\\texthvlig", "\\texthvlig"),
    ..entry("\\texthth", "\\texthth"),
    ..entry("\\textturnh", "\\textturnh"),
    ..entry("4", "4"),
    ..entry("\\textsch", "\\textsch"),
    // I
    ..entry("\\i", "\\i"),
    ..entry("\\textbari", "\\textbari"),
    ..entry("\\textiota", "\\textiota"),
    ..entry("\\textlhti", "\\textlhti"),
    ..entry("\\textsci", "\\textsci"),
    // J
    ..entry("\\j", "\\j"),
    ..entry("\\textctj", "\\textctj"),
    ..entry("\\textscj", "\\textscj"),
    ..entry("\\;J", "\\;J"),
    ..entry("\\v{\\j}", "\\v{\\j}"),
    ..entry("\\textObardotlessj", "\\textObardotlessj"),
    ..entry("\\texthtbardotlessj", "\\texthtbardotlessj"),
    // K
    ..entry("\\texthtk", "\\texthtk"),
    ..entry("\\textturnk", "\\textturnk"),
    // L
    ..entry("\\textltilde", "\\textltilde"),
    ..entry("\\textbarl", "\\textbarl"),
    ..entry("\\textrtaill", "\\textrtaill"),
    ..entry("\\textOlyoghlig", "\\textOlyoghlig"),
    ..entry("\\textscl", "\\textscl"),
    ..entry("\\textlambda", "\\textlambda"),
    ..entry("\\textcrlambda", "\\textcrlambda"),
    // M
    ..entry("\\textltailm", "\\textltailm"),
    ..entry("\\textturnm", "\\textturnm"),
    // N
    ..entry("\\textnrleg", "\\textnrleg"),
    ..entry("\\ng", "\\ng"),
    ..entry("\\textrtailn", "\\textrtailn"),
    ..entry("\\textctn", "\\textctn"),
    ..entry("\\textscn", "\\textscn"),
    // O
    ..entry("\\textbullseye", "\\textbullseye"),
    ..entry("\\textbaro", "\\textbaro"),
    ..entry("\\textscoelig", "\\textscoelig"),
    ..entry("\\textopeno", "\\textopeno"),
    ..entry("\\textomega", "\\textomega"),
    ..entry("\\textcloseomega", "\\textcloseomega"),
    // P
    ..entry("\\textwynn", "\\textwynn"),
    ..entry("\\textthorn", "\\textthorn"),
    ..entry("\\th", "\\th"),
    ..entry("\\texthtp", "\\texthtp"),
    ..entry("\\textphi", "\\textphi"),
    // Q
    ..entry("\\texthtq", "\\texthtq"),
    // R
    ..entry("\\textfishhookr", "\\textfishhookr"),
    ..entry("\\textlonglegr", "\\textlonglegr"),
    ..entry("\\textrtailr", "\\textrtailr"),
    ..entry("\\textturnr", "\\textturnr"),
    ..entry("\\textturnrrtail", "\\textturnrrtail"),
    ..entry("\\textscr", "\\textscr"),
    ..entry("\\textinvscr", "\\textinvscr"),
    // S
    ..entry("\\v{s}", "\\v{s}"),
    ..entry("\\textrtails", "\\textrtails"),
    ..entry("\\textesh", "\\textesh"),
    ..entry("\\textctesh", "\\textctesh"),
    // T
    ..entry("\\texthtt", "\\texthtt"),
    ..entry("\\textlhookt", "\\textlhookt"),
    ..entry("\\textrtailt", "\\textrtailt"),
    ..entry("\\texttctclig", "\\texttctclig"),
    ..entry("\\texttslig", "\\texttslig"),
    ..entry("\\texteshlig", "\\texteshlig"),
    ..entry("\\textturnt", "\\textturnt"),
    ..entry("\\textctt", "\\textctt"),
    ..entry("\\texttheta", "\\texttheta"),
    // U
    ..entry("\\textbaru", "\\textbaru"),
    ..entry("\\textupsilon", "\\textupsilon"),
    ..entry("\\textscu", "\\textscu"),
    ..entry("\\;U", "\\;U"),
    // V
    ..entry("\\textscriptv", "\\textscriptv"),
    // W
    ..entry("\\textturnw", "\\textturnw"),
    // X
    ..entry("\\textchi", "\\textchi"),
    // Y
    ..entry("\\textturny", "\\textturny"),
    ..entry("\\textscy", "\\textscy"),
    // Z
    ..entry("\\textcommatailz", "\\textcommatailz"),
    ..entry("\\v{z}", "\\v{z}"),
    ..entry("\\textrevyogh", "\\textrevyogh"),
    ..entry("\\textrtailz", "\\textrtailz"),
    ..entry("\\textyogh", "\\textyogh"),
    ..entry("\\textctyogh", "\\textctyogh"),
    ..entry("\\textcrtwo", "\\textcrtwo"),
    ..entry("\\textglotstop", "\\textglotstop"),
    ..entry("\\textraiseglotstop", "\\textraiseglotstop"),
    ..entry("\\textinvglotstop", "\\textinvglotstop"),
    ..entry("\\textrevglotstop", "\\textrevglotstop"),
  ))
]
