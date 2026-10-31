#import "/prosody.typ": convert-prosody-input, parse-syllable
#import "/ipa.typ": strip-tones, tone-letters
#import "/sonority.typ": parse-phonemes

// Tone describes the syllable: set aside wherever it was typed, never a segment
#assert.eq(parse-syllable("ma˥˩"), (onset: "m", nucleus: "a", coda: "", tone: "˥˩"))
#assert.eq(parse-syllable("man˥˩"), (onset: "m", nucleus: "a", coda: "n", tone: "˥˩"))
#assert.eq(parse-syllable("ma˥˩n"), (onset: "m", nucleus: "a", coda: "n", tone: "˥˩"))
#assert.eq(parse-syllable("aː˨˩˦"), (onset: "", nucleus: "aː", coda: "", tone: "˨˩˦"))
#assert.eq(parse-syllable("t͡sʰa˥˥"), (onset: "t͡sʰ", nucleus: "a", coda: "", tone: "˥˥"))
#assert.eq(parse-syllable("m̩˨˩"), (onset: "", nucleus: "m̩", coda: "", tone: "˨˩"))
#assert.eq(parse-syllable("waɪ˧˥"), (onset: "w", nucleus: "aɪ", coda: "", tone: "˧˥"))
#assert.eq(parse-syllable("a꜒꜖꜈꜍"), (onset: "", nucleus: "a", coda: "", tone: "꜒꜖꜈꜍"))
// No vowel: the tone still belongs to the syllable
#assert.eq(parse-syllable("pf˥"), (onset: "pf", nucleus: "", coda: "", tone: "˥"))
// No tone: empty field
#assert.eq(parse-syllable("man"), (onset: "m", nucleus: "a", coda: "n", tone: ""))

// Tone commands alone, for non-IPA labels
#assert.eq(tone-letters("ma\\tone{55}"), "ma˥˥")
#assert.eq(tone-letters("S \\ltone{1}"), "S ꜖")
#assert.eq(tone-letters("Ti"), "Ti")
#assert-panic(() => tone-letters("\\tone{9}"))
#assert.eq(strip-tones("a \\tone{5}"), "a")
#assert.eq(strip-tones("a: \\tone{51}"), "a:")
#assert.eq(strip-tones("a˥˩"), "a")
#assert.eq(strip-tones("a"), "a")

// Sonority: tone letters are not segments; they go on the syllable's peak
// and do not shift syllable boundaries
#assert.eq(parse-phonemes("ma˥˩.ta˧˥"), (("m", "a˥˩", "t", "a˧˥"), (2,)))
#assert.eq(parse-phonemes("man˥˩"), (("m", "a˥˩", "n"), ()))
#assert.eq(parse-phonemes("ma˥˩ta˧˥"), (("m", "a˥˩", "t", "a˧˥"), ()))
#assert.eq(parse-phonemes("waɪ˧˥"), (("w", "a˧˥", "ɪ"), ()))
#assert.eq(parse-phonemes("˥ma"), (("m", "a"), ()))

// Accented vowels are nuclei, precomposed or not
#assert.eq(parse-syllable("tá"), (onset: "t", nucleus: "á", coda: "", tone: ""))
#assert.eq(parse-syllable("tǎn"), (onset: "t", nucleus: "ǎ", coda: "n", tone: ""))
#assert.eq(parse-syllable("ta\u{301}"), (onset: "t", nucleus: "a\u{301}", coda: "", tone: ""))
// \' is a tone accent, not a stress mark; a bare ' still is
#assert.eq(convert-prosody-input("t \\' a"), "ta\u{301}")
#assert.eq(convert-prosody-input("'t \\' a.ta"), "'ta\u{301}.ta")

// Modifiers stack after any segment, affricates included (was: t͡s + ʰ)
#import "/prosody.typ": smart-clusters
#assert.eq(smart-clusters("t͡sʰa"), ("t͡sʰ", "a"))
#assert.eq(smart-clusters("kʷʰa"), ("kʷʰ", "a"))
#assert.eq(smart-clusters("pʼa"), ("pʼ", "a"))
#assert.eq(smart-clusters("aːn"), ("aː", "n"))
#assert.eq(smart-clusters("t͡ʃa"), ("t͡ʃ", "a"))
#assert.eq(parse-syllable("t͡sʰaŋ˥˥"), (onset: "t͡sʰ", nucleus: "a", coda: "ŋ", tone: "˥˥"))

// Stress marks at the start of a syllable
#import "/prosody.typ": split-stress
#assert.eq(split-stress("'ta"), ("ta", true, true, false))
#assert.eq(split-stress(",ta"), ("ta", true, false, false))
#assert.eq(split-stress("ta"), ("ta", false, false, false))
// A second mark, or one inside the syllable, is misplaced
#assert.eq(split-stress("',ta"), (",ta", true, true, true))
#assert.eq(split-stress("''ta"), ("'ta", true, true, true))
#assert.eq(split-stress("t'a"), ("t'a", false, false, true))
