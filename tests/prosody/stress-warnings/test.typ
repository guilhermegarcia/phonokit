#import "/lib.typ": *
#set page(width: auto, height: auto, margin: 0.5em)

// Two heads in one foot, in every function with feet
#foot("'ta.'ta") \
#foot-mora(",ta.'ta") \
#word("('ta.ta)(,ta.'ta)") \
#word-mora("(,ta.,ta)")

// A second mark, or a mark inside a syllable
#syllable("',ta") \
#mora("t'a") \
#word("(,'ta.ta)") \
#foot("''ta.ta")

// Not warnings: several feet with ', or several ' without feet
#word("('ta.ta)('ta.ta)") #word("'ta.'ta.ta")
