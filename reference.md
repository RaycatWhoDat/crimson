# Crimson v0.0.9

## API Reference
### only
```
USAGE:
     iterable only item

DESCRIPTION: 
     Returns all occurrences of ITEM in ITERABLE. 
     ONLY is an op! value.

ARGUMENTS:
     iterable     [block! string!] "The iterable to parse over."
     item         [block! typeset! datatype! string!] "The item to find in the iterable."

RETURNS:
     [block!]
```
### assert
```
USAGE:
     ASSERT :test-condition message

DESCRIPTION: 
     Throws an exception if a condition is false. 
     ASSERT is a function! value.

ARGUMENTS:
     :test-condition [any-type!] "The conditional in question."
     message      [block! string!] {The message to display when throwing the exception.}
```
### flatten
```
USAGE:
     FLATTEN series

DESCRIPTION: 
     Returns a flattened block of items. 
     FLATTEN is a function! value.

ARGUMENTS:
     series       [block!] "The block of items to flatten."

REFINEMENTS:
     /deep        => Flattens each nested block when present.

RETURNS:
     [block!]
```
### Z
```
USAGE:
     first-block Z second-block

DESCRIPTION: 
     Returns a series of blocks with items corresponding with both iterables. 
     Z is an op! value.

ARGUMENTS:
     first-block  [block!] "The first block to zip."
     second-block [block!] "The second block to zip."

RETURNS:
     [block!]
```
### Z!
```
USAGE:
     first-block Z! second-block

DESCRIPTION: 
     Returns a flattened block with items corresponding with both iterables. NOTE: This will not compose nicely if you don't use it as the last zipping operation. 
     Z! is an op! value.

ARGUMENTS:
     first-block  [block!] "The first block to zip."
     second-block [block!] "The second block to zip."

RETURNS:
     [block!]
```
### ..
```
USAGE:
     start .. end

DESCRIPTION: 
     Returns all natural numbers between and including START and END. 
     .. is an op! value.

ARGUMENTS:
     start        [integer! float!] "The first number in the range."
     end          [integer! float!] "The last number in the range."

RETURNS:
     [block!]
```
### R
```
USAGE:
     R end

DESCRIPTION: 
     Returns all natural numbers between and including 1 and including END. 
     R is a function! value.

ARGUMENTS:
     end          [number!] "The last number in the range."

RETURNS:
     [block!]
```
### chunk
```
USAGE:
     CHUNK iterable size

DESCRIPTION: 
     Returns a block of blocks, in groups of SIZE. 
     CHUNK is a function! value.

ARGUMENTS:
     iterable     [block! string!] "The iterable to parse over."
     size         [integer!] "The size of each block."

RETURNS:
     [block!]
```
### max-of-series
```
USAGE:
     MAX-OF-SERIES series

DESCRIPTION: 
     Returns the largest in a series, assuming the first item's datatype! is the same as the rest of the items. 
     MAX-OF-SERIES is a function! value.

ARGUMENTS:
     series       [block!] "The series to check."

RETURNS:
     [block!]
```
### weave
```
USAGE:
     WEAVE series item

DESCRIPTION: 
     Given a BLOCK! and ANY-TYPE!, returns a BLOCK! with ANY-TYPE! in-between each word. 
     WEAVE is a function! value.

ARGUMENTS:
     series       [block!] "The series to weave."
     item         [any-type!] "The item to insert."

RETURNS:
     [block!]
```
### explode
```
Looks like we have a bad type spec: [block! [char!]]
USAGE:
     EXPLODE item

DESCRIPTION: 
     Given ANY-STRING!, returns a BLOCK! of CHAR!. 
     EXPLODE is a function! value.

ARGUMENTS:
     item         [string!] "The string to explode."

RETURNS:
     [block! [char!]]
```
### char-to-integer
```
USAGE:
     CHAR-TO-INTEGER character

DESCRIPTION: 
     Given a CHAR!, this will return a INTEGER! of the value, not the code point. 
     CHAR-TO-INTEGER is a function! value.

ARGUMENTS:
     character    [char!] "The character to convert."

RETURNS:
     [integer!]
```
### format
```
USAGE:
     FORMAT format-string items

DESCRIPTION: 
     Given a string with special identifiers, replace the string with the items provided in the block. 
     FORMAT is a function! value.

ARGUMENTS:
     format-string [string!] 
     items        [block!] 

RETURNS:
     [string!]
```
