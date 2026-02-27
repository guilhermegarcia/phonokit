#import "syllabics.typ": roman, roman-to-syllabics, syllabics, syllabics-to-roman
#import "ipa.typ": ipa

// #set page(paper: "a5", margin: 2cm)
#set text(font: "Charis", size: 11pt)
#show regex("[\u{1400}-\u{167F}]"): it => text(
  font: ("Noto Sans Canadian Aboriginal", "Euphemia UCAS"),
  it,
)
#align(center)[
  #text(size: 14pt, weight: "bold")[Phonokit — Inuktitut Syllabics (demo)]
  #v(0.3em)
  #text(size: 9pt, fill: gray)[Architecture proof-of-concept — tables to be verified]
]

#v(1em)
#line(length: 100%)
#v(0.5em)

= Testing with a text

This comes from #underline(link("https://www.gov.nu.ca/ikt/tuhaagahat/kavamatkut-nunavunmi-naunaihijut-inuktitut-titiraqhimajunun-uqaqtaujut-nipiliurutikkut")[this website]).

The Government of Nunavut, in collaboration with Microsoft, proudly announces the launch of Inuktitut text-to-speech functionality in Azure AI Speech services. Text-to-speech is now available in the Edge browser, using Read Aloud, and Microsoft Translator in Bing, and with more Microsoft applications to be added in 2025. This achievement, part of the Preservation and Promotion of Inuktut Through Technology Project, led by the Department of Culture and Heritage, reflects years of dedicated, community-driven efforts to make language more accessible and integrated into daily life across Nunavut.

== Function

#syllabics(
  "Kavamatkut nunavunmi, havaqatigiblugit ukua {Microsoft}kut, quviahungnikkut tuhaqtitijut aularutaagut Inuktitut titiraqhimajunun-uqaqtaujut nipiliurutikkut aulapkaininga hamani {Azure AI Speech} kivgaqtuutaini. Titiraqhimajunun-uqaqtaujut nipiliurutikkut piinarialaqijut uvani {Edge} qiniqhiaviani, atuqhugit Taiguaqniq Nipiquqtujumik, unalu {Microsoft} Numiktirutaa uvani {Bing}mi, aalaniklu {Microsoft} uuktuutaini ilaliutijukhat uvani {2025}mi. Una iniqtirninga, ilaujuq tamaqtailinirmun Akhuurutiginirmun Inuktut Qaritaujakkut Havaakhaq, hivuliqhuqtaujuq ukunanga Havakvianin Pituqhiliqijitkut, takunaqtuq amigaituni ukiuni akhuurutit, nunallaanin-pihimajuq akhuurutit uqauhiq piinarialaqijaangani ilaujuqlu ubluni inuunirmun inuuhiq Nunavunmi.",
)

== Original

ᓄᓇᕗᑦ ᒐᕙᒪᒃᑯᑦ, ᐱᓕᕆᖃᑎᖃᖅᖢᑎᒃ Microsoft−ᑯᓐᓂ, ᐅᐱᒍᓱᒃᖢᑎᒃ ᑐᓴᖅᑎᑦᑎᕗᑦ ᓴᖅᑭᑕᐅᓂᖓᓂᒃ ᐃᓄᒃᑎᑐᑦ ᑎᑎᕋᐅᓯᑦ ᐅᖃᐅᓯᐅᔪᒃᓴᓂᒃ ᐊᐅᓚᓂᖏᓐᓂᒃ AZure AI ᐅᖃᕆᐅᖅᓴᑎᑦᑎᔨᓂᒃ. ᑎᑎᕋᖃᑦᑕᐅᑎᓂᖅ ᐅᖃᓪᓚᖕᓂᐊᕐᓗᓂ ᒫᓐᓇ ᒪᓂᒪᓕᖅᐳᑦ Edge browser−ᑯᑦ, ᐊᑐᕐᓗᒍ Read Aloud, ᐊᒻᒪᓗ Microsoft Translator Bing−ᒥ, ᐊᒻᒪᓗ ᐃᓚᔭᐅᓗᐊᒃᑲᓐᓂᓛᖅᑐᑦ Microsoft−ᒧᑦ ᐊᑐᖅᑕᐅᕙᒃᑐᓂᒃ ᐃᓚᓕᐅᔾᔭᐅᔪᖃᓛᖅᖢᓂ 2025−ᒥ. ᑕᒪᓐᓇ ᐊᓂᒍᖅᑎᑕᐅᔪᖅ, ᐃᓚᒋᔭᐅᓪᓗᓂ ᔭᒐᑎᑦᑎᑦᑕᐃᓕᒪᓂᕐᒧᑦ ᐅᔾᔨᕐᓇᖅᓯᑎᑦᑎᓂᕐᒧᓪᓗ ᐃᓄᒃᑐᑦ ᐱᓕᕆᔾᔪᑕᐅᕙᒃᑐᓄᑦ ᐱᓕᕆᐊᖑᕙᒃᑐᑎᒍᑦ, ᑲᔪᓯᑎᑕᐅᓪᓗᓂ ᐃᓕᖅᑯᓯᓕᕆᔨᒃᑯᓐᓄᑦ, ᐊᒃᑐᐊᓂᖃᖅᐳᖅ ᐊᕐᕌᒍᒐᓴᕐᓄᑦ ᐱᓕᕆᐊᖃᓪᓚᕆᒍᒪᕙᖕᓂᖏᓐᓄᑦ, ᓄᓇᓕᖕᓂ−ᑲᔪᓯᑎᑕᐅᔪᓄᑦ ᐱᓇᔪᒃᑕᐅᔪᓄᑦ ᑕᒪᓐᓇ ᐅᖃᐅᓯᖅ ᒪᓂᒪᓂᖅᓴᐅᖁᓪᓗᒍ ᐃᓚᓕᐅᔾᔭᐅᓯᒪᓗᓂᓗ ᖃᐅᑕᒫᑦ ᐃᓅᓯᕆᔭᐅᔪᓄᑦ ᓄᓇᕘᓕᒫᒥ.

// ── 1. Roman → Syllabics (Nunavut, default) ───────────────────────────────────

= Roman → Syllabics

#table(
  columns: (auto, auto, auto, auto),
  stroke: none,
  inset: (x: 0.6em, y: 0.4em),
  align: (left, center, left),
  table.header(
    text(weight: "bold")[Roman],
    text(weight: "bold")[Syllabics],
    text(weight: "bold")[Gloss],
    text(weight: "bold")[Function],
  ),
  table.hline(stroke: 0.5pt),
  [inuk], [#syllabics("inuk")], [person], [`#syllabics("inuk")`],
  [kaniq], [#syllabics("kaniq")], [frost], [`#syllabics("kaniq")`],
  [kuuk], [#syllabics("kuuk")], [river], [`#syllabics("kuuk")`],
  [silami], [#syllabics("silami")], [outside], [`#syllabics("silami")`],
  [nunavut], [#syllabics("nunavut")], [Nunavut], [`#syllabics("nunavut")`],
)

#v(1em)

// ── 2. Dialect comparison: Nunavut vs. Nunavik ────────────────────────────────

= Dialect comparison: AI diphthong

In Nunavut, /ai/ is written as the A-form syllable + standalone #syllabics("i") (i).
In Nunavik, a dedicated fourth orientation encodes /ai/ as a single character.

#table(
  columns: (auto, auto, auto, auto),
  stroke: none,
  inset: (x: 0.6em, y: 0.4em),
  align: (left, center, center, left),
  table.header(
    text(weight: "bold")[Roman],
    text(weight: "bold")[Nunavut],
    text(weight: "bold")[Nunavik],
    text(weight: "bold")[Note],
  ),
  table.hline(stroke: 0.5pt),
  [pai], [#syllabics("pai", dialect: "nunavut")],
  [#syllabics("pai", dialect: "nunavik")],
  [pa + standalone i  vs.\ dedicated AI glyph],
  [tai], [#syllabics("tai", dialect: "nunavut")],
  [#syllabics("tai", dialect: "nunavik")],
  [],
  [qai], [#syllabics("qai", dialect: "nunavut")],
  [#syllabics("qai", dialect: "nunavik")],
  [],
  [ngai], [#syllabics("ngai", dialect: "nunavut")],
  [#syllabics("ngai", dialect: "nunavik")],
  [],
)

#v(1em)

// ── 3. North Baffin: LH series (/ɬ/) ─────────────────────────────────────────

= North Baffin: LH series (#ipa("\\textbeltl"), voiceless lateral fricative)

#table(
  columns: (auto, auto),
  stroke: none,
  inset: (x: 0.6em, y: 0.4em),
  align: (left, center),
  table.header(text(weight: "bold")[Roman], text(weight: "bold")[Syllabics]),
  table.hline(stroke: 0.5pt),
  [lhi], [#syllabics("lhi", dialect: "north-baffin")],
  [lhu], [#syllabics("lhu", dialect: "north-baffin")],
  [lha], [#syllabics("lha", dialect: "north-baffin")],
  [lhii], [#syllabics("lhii", dialect: "north-baffin")],
)

#v(1em)

// ── 4. Syllabics → Roman (reverse direction) ──────────────────────────────────

= Syllabics → Roman

#table(
  columns: (auto, auto, auto),
  stroke: none,
  inset: (x: 0.6em, y: 0.4em),
  align: (center, left, left),
  table.header(text(weight: "bold")[Syllabics input], text(weight: "bold")[Roman output], text(weight: "bold")[Gloss]),
  table.hline(stroke: 0.5pt),
  [#syllabics("inuk")], [#roman("ᐃᓄᒃ")], [person],
  [#syllabics("nunavut")], [#roman("ᓄᓇᕗᑦ")], [Nunavut],
  [#syllabics("silami")], [#roman("ᓯᓚᒥ")], [outside],
)

#v(1em)

// ── 5. Roman escape syntax ────────────────────────────────────────────────────

= Roman escape: `{...}` inside syllabics

Real Inuktitut documents mix syllabics with Roman text (brand names, loanwords,
numbers). Wrap any Roman segment in `{...}` to pass it through untouched:

#block(inset: (left: 1em))[
  `#syllabics("ilitaqsinikkut {Microsoft}-mit")` \
  → #syllabics("ilitaqsinikkut {Microsoft}-mit")

  `#syllabics("sivulliqpaamik {AI}-kut {2025}-mut")` \
  → #syllabics("sivulliqpaamik {AI}-kut {2025}-mut")
]

#v(1em)

// ── 6. Inline use with IPA ────────────────────────────────────────────────────

= Inline use with IPA

The word #syllabics("inuk") #ipa("['" + "inuk]") means 'person' in Inuktitut.

The place name #syllabics("nunavut") #ipa("[nu'" + "na.vut]") means 'our land'.

Long vowels are represented by distinct precomposed characters:
#syllabics("ii") #ipa("i:"), #syllabics("uu") #ipa("u:"), #syllabics("aa") #ipa("a:"). #syllabics("")
