#import "/lib.typ": *
#assert-panic(() => consonants("english", africates: true))
#assert-panic(() => consonants("p", "t"))
