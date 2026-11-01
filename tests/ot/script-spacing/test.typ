#import "/lib.typ": *
#import "/ot.typ": parse-ot-string
#set page(width: auto, height: auto, margin: 0.5em)

// Scripts, raw text and literal braces must not overlap the preceding letter:
// each part of the string takes up its full width
#let same-width(a, b) = assert(calc.abs((a - b) / 1pt) < 0.01, message: repr((a, b)))
#context {
  let w(it) = measure(it).width
  let font = phonokit-font.get()
  let plain(s) = text(font: font, s)
  same-width(w(parse-ot-string("kraTa_{sub}")), w(ipa("kraTa")) + w(sub(plain("sub"))))
  same-width(w(parse-ot-string("kraTa^{sup}")), w(ipa("kraTa")) + w(super(plain("sup"))))
  same-width(w(parse-ot-string("a_x")), w(ipa("a")) + w(sub(plain("x"))))
  same-width(w(parse-ot-string("a{raw}")), w(ipa("a")) + w(plain("raw")))
  same-width(w(parse-ot-string("a\\{b\\}")), w(ipa("a")) + w(plain("{")) + w(ipa("b")) + w(plain("}")))
  same-width(w(parse-ot-string("a\\,")), w(ipa("a")) + w(plain(",")))
}

#tableau(
  input: "kraTa_{sub}\\, \\s kraTa^{sup}\\, \\s \\{braces\\}",
  candidates: ("kraTa_{sub}", "kraTa^{sup}", "a{raw}\\{b\\}"),
  constraints: ("Con-1",),
  violations: (("",), ("*!",), ("*!",)),
  winner: 0,
)
