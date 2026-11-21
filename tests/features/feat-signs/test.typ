#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 1em)

// Leading signs are width-compensated so feature names line up
// (Charis "+" is twice as wide as its "–").
#set math.vec(align: left)
#feat("–son", "+cont", "+dor", "–cor") #a-r #feat("+arr", "–cor") / #feat("+syll,–cons,–avant") #blank()

#feat("±RR", "∓haut", "−arr", "-voix", "+cor") #feat([–#text(fill: purple)[son]], [+#text(fill: blue)[cor]]) #feat([+cor], [–ant]) #feat(sym.alpha + [ lab], [#sym.beta labiodental])

// Center alignment (default) is unaffected apart from the sign spacing
#set math.vec(align: center)
#feat("+syll", "–cons")
