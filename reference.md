## List of Functions
### keep-occurrences
```
USAGE:
     KEEP-OCCURRENCES iterable item

DESCRIPTION: 
     Base function for keep-occurrences behavior. 
     KEEP-OCCURRENCES is a function! value.

ARGUMENTS:
     iterable     [block! string!] "The iterable to parse over."
     item         [block! typeset! datatype! string!] "The item to find in the iterable."

RETURNS:
     [block!]
```
### ~
```
USAGE:
     iterable ~ item

DESCRIPTION: 
     Returns all occurrences of ITEM in ITERABLE. 
     ~ is an op! value.

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
     message      [string!] {The message to display when throwing the exception.}
```
### zip
```
USAGE:
     ZIP first-block second-block

DESCRIPTION: 
     Base function for zipping behavior. 
     ZIP is a function! value.

ARGUMENTS:
     first-block  [block!] "The first block to zip."
     second-block [block!] "The second block to zip."

REFINEMENTS:
     /flat        => Flattens items when present. NOTE: This will not compose nicely.

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
     Returns a flattened block with items corresponding with both iterables. NOTE: This will not compose nicely like Z does. 
     Z! is an op! value.

ARGUMENTS:
     first-block  [block!] "The first block to zip."
     second-block [block!] "The second block to zip."

RETURNS:
     [block!]
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
     series       [block!] 

RETURNS:
     [block!]
```
### install
```
USAGE:
     INSTALL 

DESCRIPTION: 
     INSTALL is a function! value.
```
### generate-reference
```
USAGE:
     GENERATE-REFERENCE 

DESCRIPTION: 
     GENERATE-REFERENCE is a function! value.
```
