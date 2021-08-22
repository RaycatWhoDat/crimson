Red [
    Title: "Crimson"
    Author: "RaycatWhoDat"
    Description: {
        Crimson is a collection of functions and operators that
        I found myself wanting as I made test projects with Red.
    }
    File: %crimson.red
    Tabs: 4
    Version: 0.0.1
]

flatten: function [
    "Returns a flattened block of items."
    series [block!] "The block of items to flatten."
    return: [block!]
    /deep "Flattens each nested block when present."
] [
    either deep [
        flattened-series: make block! length? series
        nested-block: [
            into [some nested-block]
            | set value skip (append flattened-series value)
        ]
        parse series [some nested-block]
        flattened-series
    ] [
        flattened-series: make block! length? series
        head any [
            foreach value series [
                insert tail flattened-series value
            ]
            flattened-series
        ]
    ]
]

Z: make op! function [
    "Returns a series of blocks with items corresponding with both iterables."
    first-block [block!] "The first block to zip."
    second-block [block!] "The second block to zip."
    return: [block!]
] [
    collect [
        forall first-block [
            keep/only append to block! first-block/1 pick second-block index? first-block
        ]
    ]
]

Z!: make op! function [
    "Returns a flattened block with items corresponding with both iterables. NOTE: This will not compose nicely like Z does."
    first-block [block!] "The first block to zip."
    second-block [block!] "The second block to zip."
    return: [block!]
] [
    collect [
        forall first-block [
            keep append to block! first-block/1 pick second-block index? first-block
        ]
    ]
]

..: make op! function [
    "Returns all natural numbers between and including START and END."
    start [integer! float!] "The first number in the range."
    end [integer! float!] "The last number in the range."
    return: [block!]
] [
	if start = end [return []]
	is-start-smaller: start < end
	total: either is-start-smaller [end - start + 1] [start - end + 1]
	collect [
		repeat index total [
			keep start + either is-start-smaller [index - 1] [-1 * (index - 1)]
		]
	]
]

R: function [
    "Returns all natural numbers between and including 1 and including END."
    end [number!] "The last number in the range."
    return: [block!]
] [
    either end > 1 [
        1 .. end
    ] [
        copy []
    ]
]

max-of-series: function [
    "Returns the largest in a series, assuming the first item's datatype! is the same as the rest of the items."
    series [block!]
    return: [block!]
] [
    type-assumption: type? series/1
    all-comparable-items: parse series [collect [some [keep type-assumption to type-assumption]]]
    largest-item: none
    foreach item all-comparable-items [
        if none? largest-item [largest-item: item]
        if item > largest-item [largest-item: item]
    ]
    largest-item
]

assert: function [
    "Throws an exception if a condition is false."
    :test-condition [any-type!] "The conditional in question."
    message [string!] "The message to display when throwing the exception."
] [
    if not do :test-condition [
        both-sides: parse test-condition [collect [some [keep series! skip keep any-type!]]]
        print compose ["Expected:" (last both-sides)]
        print compose ["Actual:" (first both-sides)]
        do make error! message
    ]
]

;
; Flatten tests
;
assert [(flatten (R 5) Z (6 .. 10)) = [1 6 2 7 3 8 4 9 5 10]] "Flatten did not return the correct result."
assert [(flatten/deep [-1 0 [1 2 [3 4 5 [6]]]]) = [-1 0 1 2 3 4 5 6]] "Flatten/deep did not return the correct result."

;
; Zip tests
;
assert [(R 5) Z (6 .. 10) = [[1 6] [2 7] [3 8] [4 9] [5 10]]] "Zip (Z) did not return correct the result."
assert [(R 5) Z (6 .. 10) Z (11 .. 15) = [[1 6 11] [2 7 12] [3 8 13] [4 9 14] [5 10 15]]] "Zip (Z) does not compose properly."
assert [(R 5) Z! (6 .. 10) = [1 6 2 7 3 8 4 9 5 10]] "Flattening zip (Z!) did not return correct the result."

;
; Range tests
;
assert [(1 .. 10) = [1 2 3 4 5 6 7 8 9 10]] "Small Pos to Large Pos did not return the correct result."
assert [(10 .. 1) = [10 9 8 7 6 5 4 3 2 1]] "Large Pos to Small Pos did not return the correct result."
assert [(-10 .. -1) = [-10 -9 -8 -7 -6 -5 -4 -3 -2 -1]] "Small Neg to Large Neg did not return the correct result."
assert [(-1 .. -10) = [-1 -2 -3 -4 -5 -6 -7 -8 -9 -10]] "Large Neg to Small Neg did not return the correct result."
assert [(-5 .. 5) = [-5 -4 -3 -2 -1 0 1 2 3 4 5]] "Small Neg to Large Pos did not return the correct result."
assert [(5 .. -5) = [5 4 3 2 1 0 -1 -2 -3 -4 -5]] "Large Pos to Small Neg did not return the correct result."
assert [(R 10) = [1 2 3 4 5 6 7 8 9 10]] "Unspecified Large Pos did not return the correct result."
assert [(0 .. 0) = []] "Same Ends did not return the correct result."

;
; Max-of-series
;
assert [(max-of-series (-10 .. -1)) = -1] "Max-of-series did not return the correct result."
assert [(max-of-series (-10 .. 10)) = 10] "Max-of-series did not return the correct result."
assert [(max-of-series [-32 "e" 1 "a" 42]) = 42] "Max-of-series did not return the correct result."
