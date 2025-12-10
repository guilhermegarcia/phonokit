#import "@preview/cetz:0.4.2"

#let is-vowel(char) = {
  char in ("a", 
           "e", 
           "i", 
           "o", 
           "u", 
           "ã",
           "ẽ",
           "õ",
           "ɛ̃",
           "ɔ̃",
           "œ̃",
           "ɑ̃",
           "ɚ",
           "ɝ",
           "ɯ",
           "ɐ",
           "ɒ",
           "æ", 
           "ɛ", 
           "ɪ", 
           "ɔ", 
           "ø",
           "ɪ",
           "œ",
           "ɨ",
           "ʉ",
           "ʊ", 
           "ə", 
           "ʌ", 
           "ɑ", 
           "aɪ", 
           "eɪ", 
           "oɪ", 
           "aʊ", 
           "oʊ")
}

#let parse-syllable(syll) = {
  let chars = syll.codepoints()
  let onset = ""
  let nucleus = ""
  let coda = ""
  let found-nucleus = false

  for char in chars {
    if is-vowel(char) {
      nucleus += char
      found-nucleus = true
    } else if not found-nucleus {
      onset += char
    } else {
      coda += char
    }
  }

  (onset: onset, nucleus: nucleus, coda: coda)
}

// Helper function to draw syllable internal structure
#let draw-syllable-structure(x-offset, sigma-y, syll, terminal-y, diagram-scale: 1.0) = {
  import cetz.draw: *

  let has-onset = syll.onset != ""
  let has-coda = syll.coda != ""

  let onset-x = if has-onset { x-offset - 0.7 } else { x-offset }
  let rhyme-x = if has-onset { x-offset + 0.7 } else { x-offset }
  let nucleus-x = if has-coda { rhyme-x - 0.48 } else { rhyme-x }
  let coda-x = if has-coda { rhyme-x + 0.35 } else { rhyme-x }

  // Branches from syllable
  if has-onset {
    line((x-offset, sigma-y + 0.25), (onset-x, sigma-y - 0.45))
    content((onset-x, sigma-y - 0.75), text(size: 10 * diagram-scale * 1pt)[On])
    line((onset-x, sigma-y - 1.1), (onset-x, terminal-y + 0.30))
    content((onset-x, terminal-y), text(size: 11 * diagram-scale * 1pt)[#syll.onset], anchor: "north")
  }

  // Rhyme branch
  line((x-offset, sigma-y + 0.25), (rhyme-x, sigma-y - 0.45))
  content((rhyme-x, sigma-y - 0.75), text(size: 10 * diagram-scale * 1pt)[Rh])

  // Nucleus
  line((rhyme-x, sigma-y - 1.1), (nucleus-x, sigma-y - 1.35))
  content((nucleus-x, sigma-y - 1.65), text(size: 10 * diagram-scale * 1pt)[Nu])
  line((nucleus-x, sigma-y - 1.9), (nucleus-x, terminal-y + 0.30))
  content((nucleus-x, terminal-y), text(size: 11 * diagram-scale * 1pt)[#syll.nucleus], anchor: "north")

  // Coda (if exists)
  if has-coda {
    line((rhyme-x, sigma-y - 1.1), (coda-x, sigma-y - 1.35))
    content((coda-x, sigma-y - 1.65), text(size: 10 * diagram-scale * 1pt)[Co])
    line((coda-x, sigma-y - 1.9), (coda-x, terminal-y + 0.30))
    content((coda-x, terminal-y), text(size: 11 * diagram-scale * 1pt)[#syll.coda], anchor: "north")
  }
}

// Visualizes a single syllable's internal structure (On/Rh/Nu/Co)
#let syllable(input, scale: 1.0) = {
  // Parse a single syllable
  let clean-input = if input.starts-with("'") { input.slice(1) } else { input }
  let parsed = parse-syllable(clean-input)
  let syll = (
    onset: parsed.onset,
    nucleus: parsed.nucleus,
    coda: parsed.coda,
    stressed: input.starts-with("'")
  )

  let diagram-scale = scale  // Capture scale value to avoid conflict with cetz.draw.scale

  cetz.canvas(length: 1cm * diagram-scale, {
    import cetz.draw: *
    set-style(stroke: 0.7 * diagram-scale * 1pt)

    let sigma-y = 0
    let terminal-y = -3.5
    let x-offset = 0

    // Syllable node (σ)
    content((x-offset, sigma-y + 0.54), text(size: 12 * diagram-scale * 1pt)[*σ*])

    draw-syllable-structure(x-offset, sigma-y, syll, terminal-y, diagram-scale: diagram-scale)
  })
}

// Visualizes foot and syllable levels
#let foot(input, scale: 1.0) = {
  // Parse syllables from dotted input like "ka.'va.lo"
  // All syllables are part of the foot
  let syllables = ()
  let buffer = ""
  let chars = input.codepoints()
  let i = 0

  while i < chars.len() {
    let char = chars.at(i)

    if char == "." {
      if buffer != "" {
        let clean-buffer = if buffer.starts-with("'") { buffer.slice(1) } else { buffer }
        let parsed = parse-syllable(clean-buffer)
        syllables.push((
          onset: parsed.onset,
          nucleus: parsed.nucleus,
          coda: parsed.coda,
          stressed: buffer.starts-with("'")
        ))
        buffer = ""
      }
    } else {
      buffer += char
    }
    i += 1
  }

  // Handle remaining buffer
  if buffer != "" {
    let clean-buffer = if buffer.starts-with("'") { buffer.slice(1) } else { buffer }
    let parsed = parse-syllable(clean-buffer)
    syllables.push((
      onset: parsed.onset,
      nucleus: parsed.nucleus,
      coda: parsed.coda,
      stressed: buffer.starts-with("'")
    ))
  }

  // Find stressed syllable (head of foot)
  let head-idx = 0
  for (i, syll) in syllables.enumerate() {
    if syll.stressed {
      head-idx = i
    }
  }

  let diagram-scale = scale  // Capture scale value to avoid conflict with cetz.draw.scale

  cetz.canvas(length: 1cm * diagram-scale, {
    import cetz.draw: *
    set-style(stroke: 0.7 * diagram-scale * 1pt)

    let spacing = 3.0
    let num-sylls = syllables.len()
    let total-width = (num-sylls - 1) * spacing
    let start-x = -total-width / 2
    let foot-x = start-x + head-idx * spacing

    // Draw Ft node above the head
    content((foot-x, -0.9), text(size: 12 * diagram-scale * 1pt)[*Σ*])

    // Draw syllables
    for (i, syll) in syllables.enumerate() {
      let x-offset = start-x + i * spacing
      let sigma-y = -2.4
      let terminal-y = -5

      // Syllable node (σ)
      content((x-offset, sigma-y + 0.54), text(size: 12 * diagram-scale * 1pt)[*σ*])

      // Line from Ft to σ
      line((foot-x, -1.15), (x-offset, sigma-y + 0.8))

      draw-syllable-structure(x-offset, sigma-y, syll, terminal-y, diagram-scale: diagram-scale)
    }
  })
}

// Visualizes word, foot, and syllable levels
#let word(input, foot: "R", scale: 1.0) = {
  // Parse syllables and feet from bracketed input like "(ka.'va).lo"
  // Parentheses indicate foot boundaries
  // foot: "R" (right-aligned) or "L" (left-aligned) - determines PWd alignment

  let syllables = ()
  let feet = ()  // Array of arrays, each containing syllable indices
  let current-foot = ()
  let in-foot = false
  let buffer = ""

  // Parse the input character by character
  let chars = input.codepoints()
  let i = 0

  while i < chars.len() {
    let char = chars.at(i)

    if char == "(" {
      // Start a new foot
      in-foot = true
      current-foot = ()
    } else if char == ")" {
      // End current foot - add any buffered syllable
      if buffer != "" {
        let clean-buffer = if buffer.starts-with("'") { buffer.slice(1) } else { buffer }
        let parsed = parse-syllable(clean-buffer)
        syllables.push((
          onset: parsed.onset,
          nucleus: parsed.nucleus,
          coda: parsed.coda,
          stressed: buffer.starts-with("'")
        ))
        current-foot.push(syllables.len() - 1)
        buffer = ""
      }
      // Save this foot
      if current-foot.len() > 0 {
        feet.push(current-foot)
      }
      in-foot = false
    } else if char == "." {
      // Syllable boundary
      if buffer != "" {
        let clean-buffer = if buffer.starts-with("'") { buffer.slice(1) } else { buffer }
        let parsed = parse-syllable(clean-buffer)
        syllables.push((
          onset: parsed.onset,
          nucleus: parsed.nucleus,
          coda: parsed.coda,
          stressed: buffer.starts-with("'")
        ))

        if in-foot {
          current-foot.push(syllables.len() - 1)
        }
        // If not in foot, this syllable is footless

        buffer = ""
      }
    } else {
      buffer += char
    }

    i += 1
  }

  // Handle any remaining buffer
  if buffer != "" {
    let clean-buffer = if buffer.starts-with("'") { buffer.slice(1) } else { buffer }
    let parsed = parse-syllable(clean-buffer)
    syllables.push((
      onset: parsed.onset,
      nucleus: parsed.nucleus,
      coda: parsed.coda,
      stressed: buffer.starts-with("'")
    ))

    if in-foot {
      current-foot.push(syllables.len() - 1)
    }
  }

  // Determine which syllables are in feet
  let in-foot-set = ()
  for foot in feet {
    for syll-idx in foot {
      in-foot-set.push(syll-idx)
    }
  }

  let diagram-scale = scale  // Capture scale value to avoid conflict with cetz.draw.scale

  // Draw the structure
  cetz.canvas(length: 1cm * diagram-scale, {
    import cetz.draw: *

    set-style(stroke: 0.7 * diagram-scale * 1pt)

    let spacing = 3.0
    let num-sylls = syllables.len()
    let total-width = (num-sylls - 1) * spacing
    let start-x = -total-width / 2

    // Calculate PWd position (aligned with leftmost or rightmost foot)
    let pwd-height = 0.5 + (num-sylls * 0.1)
    let pwd-x = 0  // default center

    if feet.len() > 0 {
      // Find leftmost or rightmost foot and align PWd with it
      let target-foot = if foot == "L" { feet.at(0) } else { feet.at(-1) }

      // Find the stressed syllable (head) in the target foot
      let head-idx = target-foot.at(0)
      for syll-idx in target-foot {
        if syllables.at(syll-idx).stressed {
          head-idx = syll-idx
        }
      }
      pwd-x = start-x + head-idx * spacing
    }

    content((pwd-x, pwd-height), text(size: 12 * diagram-scale * 1pt)[*PWd*])

    // Draw footless syllables (connect directly to PWd)
    for (i, syll) in syllables.enumerate() {
      if i not in in-foot-set {
        let x-offset = start-x + i * spacing
        let sigma-y = -2.4
        let terminal-y = -5

        // Syllable node (σ)
        content((x-offset, sigma-y + 0.54), text(size: 12 * diagram-scale * 1pt)[*σ*])

        // Line from PWd to σ (footless)
        line((pwd-x, pwd-height - 0.3), (x-offset, sigma-y + 0.75))

        draw-syllable-structure(x-offset, sigma-y, syll, terminal-y, diagram-scale: diagram-scale)
      }
    }

    // Draw each foot
    for foot in feet {
      // Position Ft node above the stressed syllable (head of foot)
      // Find the stressed syllable in this foot
      let head-idx = foot.at(0)  // default to first syllable
      for syll-idx in foot {
        if syllables.at(syll-idx).stressed {
          head-idx = syll-idx
        }
      }

      let foot-x = start-x + head-idx * spacing

      // Draw Ft node above the head
      content((foot-x, -0.9), text(size: 12 * diagram-scale * 1pt)[*Σ*])

      // Line from PWd to Ft
      line((pwd-x, pwd-height - 0.3), (foot-x, -0.65))

      // Draw syllables in this foot
      for syll-idx in foot {
        let x-offset = start-x + syll-idx * spacing
        let syll = syllables.at(syll-idx)
        let sigma-y = -2.4
        let terminal-y = -5

        // Syllable node (σ)
        content((x-offset, sigma-y+0.54), text(size: 12 * diagram-scale * 1pt)[*σ*])

        // Line from Ft to σ (naturally vertical for head, angled for others)
        line((foot-x, -1.15), (x-offset, sigma-y + 0.8))

        draw-syllable-structure(x-offset, sigma-y, syll, terminal-y, diagram-scale: diagram-scale)
      }
    }
  })
}
