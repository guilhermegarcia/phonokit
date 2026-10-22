#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

#grid(columns: 3, gutter: 1em,
  vowels("english", scale: 0.4),
  vowels("french", scale: 0.4),
  vowels("german", scale: 0.4),
  vowels("italian", scale: 0.4),
  vowels("portuguese", scale: 0.4),
  vowels("spanish", scale: 0.4),
)
