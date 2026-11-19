#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// A shifted copy starts from where its own label sits in the chart:
// "i" and "iː" shifted by the same x keep their i's aligned (i plotted alone)
#vowels("i u", shift: (("i", 0.6, -0.4), ("i:", 0.6, -1.0)), scale: 0.6)

// With "i iː" plotted, the shifted iː starts from iː's slot, so a (0, -1.4)
// shift sits right under it; arrows and highlights follow the copy
#vowels("i i: u", shift: (("i", 0, -1.4), ("i:", 0, -1.4)),
  highlight: (("i:", 0, -1.4),), arrows: (("i:", ("i:", 0, -1.4)),), scale: 0.6)

// Arrows are drawn above the white masks: the head reaching a close shifted
// copy is whole, not cut by the copy's mask
#vowels("i: u", shift: (("i:", 0.6, -0.4),), arrows: (("i:", ("i:", 0.6, -0.4)),), scale: 0.6)
