Red [
    Title: "Crimson"
    Author: "RaycatWhoDat"
    Description: {
        Crimson is a collection of functions and operators that
        I found myself wanting as I made test projects with Red.
    }
    File: %crimson.red
    Tabs: 4
    Version: 0.0.2
]

keep-occurrences: function [
    "Base function for keep-occurrences behavior."
    iterable [block! string!] "The iterable to parse over."
    item [typeset! datatype! string!] "The item to find in the iterable."
    return: [block!]
] [
    parse iterable [collect [some [to item keep item to item]]]
]

~: make op! function [
    "Returns all occurrences of ITEM in ITERABLE."
    iterable [block! string!] "The iterable to parse over."
    item [typeset! datatype! string!] "The item to find in the iterable."
    return: [block!]
] [
    keep-occurrences iterable item
]

assert: function [
    "Throws an exception if a condition is false."
    :test-condition [any-type!] "The conditional in question."
    message [string!] "The message to display when throwing the exception."
] [
    if not do :test-condition [
        both-sides: test-condition ~ any-type!
        print compose ["Expected:" both-sides]
        print compose ["Actual:" (first both-sides)]
        do make error! message
    ]
]

zip: function [
    "Base function for zipping behavior."
    first-block [block!] "The first block to zip."
    second-block [block!] "The second block to zip."
    /flat "Flattens items when present. NOTE: This will not compose nicely."
    return: [block!]
] [
    collect [
        operation-mode: either flat [
            [keep]
        ] [
            [keep/only]
        ]

        forall first-block [
            do compose [(operation-mode) append to block! first-block/1 pick second-block index? first-block]
        ]
    ]
]

Z: make op! function [
    "Returns a series of blocks with items corresponding with both iterables."
    first-block [block!] "The first block to zip."
    second-block [block!] "The second block to zip."
    return: [block!]
] [
    zip first-block second-block
]

Z!: make op! function [
    "Returns a flattened block with items corresponding with both iterables. NOTE: This will not compose nicely like Z does."
    first-block [block!] "The first block to zip."
    second-block [block!] "The second block to zip."
    return: [block!]
] [
    zip/flat first-block second-block
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
        []
    ]
]

chunk: function [
    "Returns a block of blocks, in groups of SIZE."
    iterable [block! string!] "The iterable to parse over."
    size [integer!] "The size of each block."
    return: [block!]
] [
    assert [size > 0] "SIZE cannot be less than 1."
    collect [
        items: []
        forall iterable [
            append items iterable/1
            if (length? iterable) = 1 [keep/only copy items clear items break] 
            if (length? items) >= size [keep/only copy items clear items]
        ]
    ]
]

max-of-series: function [
    "Returns the largest in a series, assuming the first item's datatype! is the same as the rest of the items."
    series [block!]
    return: [block!]
] [
    type-assumption: type? series/1
    all-comparable-items: series ~ type-assumption
    largest-item: none
    foreach item all-comparable-items [
        if none? largest-item [largest-item: item]
        if item > largest-item [largest-item: item]
    ]
    largest-item
]

;
; Keep-occurrences tests
;
assert [((R 10) ~ number!) = [1 2 3 4 5 6 7 8 9 10]] "Keep-occurrences did not return the correct result."
assert [([none 1 "a" 2 "b" 3 "c"] ~ number!) = [1 2 3]] "Keep-occurrences did not return the correct result."
assert [([none 1 "a" 2 "b" 3 "c"] ~ string!) = ["a" "b" "c"]] "Keep-occurrences did not return the correct result."
assert [("this is a test" ~ "t") = [#"t" #"t" #"t"]] "Keep-occurrences did not return the correct result."

;
; Zip tests
;
assert [(R 5) Z (6 .. 10) = [[1 6] [2 7] [3 8] [4 9] [5 10]]] "Zip (Z) did not return correct the result."
assert [(R 5) Z (6 .. 10) Z (11 .. 15) = [[1 6 11] [2 7 12] [3 8 13] [4 9 14] [5 10 15]]] "Zip (Z) does not compose properly."
assert [(R 5) Z! (6 .. 10) = [1 6 2 7 3 8 4 9 5 10]] "Flattening zip (Z!) did not return correct the result."

;
; Flatten tests
;
assert [(flatten (R 5) Z (6 .. 10)) = [1 6 2 7 3 8 4 9 5 10]] "Flatten did not return the correct result."
assert [(flatten/deep [-1 0 [1 2 [3 4 5 [6]]]]) = [-1 0 1 2 3 4 5 6]] "Flatten/deep did not return the correct result."

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
; Chunk tests
;
assert [(chunk (R 10) 2) = [[1 2] [3 4] [5 6] [7 8] [9 10]]] "Chunk did not return the correct result."
assert [(chunk (R 9) 2) = [[1 2] [3 4] [5 6] [7 8] [9]]] "Chunk did not return the correct result."

;
; Max-of-series
;
assert [(max-of-series (-10 .. -1)) = -1] "Max-of-series did not return the correct result."
assert [(max-of-series (-10 .. 10)) = 10] "Max-of-series did not return the correct result."
assert [(max-of-series [-32 "e" 1 "a" 42]) = 42] "Max-of-series did not return the correct result."
