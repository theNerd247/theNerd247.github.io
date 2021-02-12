conix: with conix; [

{ tags = [ "monoids" ];
  draft = true;
}

"# "{title = "Monoids and Perfect Numbers"; }

''
# The Problem 

A perfect number is a number that is equivalent to the sum of its divisors
(except it self). For example `6` is a perfect number because `1 + 2 + 3 = 6`
where `1`, `2`, and `3` are all the divisors of `6`. However, `9` is not a
perfect number because `9 ≠ 1 + 3`. 

It turns out all known perfect numbers follow a pattern in binary:

''(code "" ''

6 = 110
${2^4 + 2^3 + 2^2} = 11100
${2^6 + 2^5 + 2^4 + 2^3} = 1111000

'')''
Each perfect number is a series of `1`s followed by `0`s where their is one
less `0`s than there are `1`s. Note however that a binary number can have
many `0`s to the left of the sequence of `1`s. So when checking if a number
is perfect we have to be sure to check that all bits to the left of the
sequence of `1`s are all zeros.

To restate it another way:

''{perfectNumDef = ''
> A perfect number is a sequence of `0`s to the left of a sequence of `1`s and
> a sequence of `0`s to the right of a sequence of `1`s where the number
> of `0`s on the right are one less than the number of `1`s.
'';}''


The algorithm for figuring this out whether a finite binary number is perfect
is fairly straight forward:

''(code "" ''
traversing from the least signifigant bit and going towards the most
signifigant bit:

1. set a flag that we are counting zeros.
1. count the number of consecutive `0`s. Save the count in a variable called
`zerosCount`.
1. Once we've reached a `1` set a flag to denote we are counting ones.
1. start counting the number of consecutive `1`s.  Save the count in a
variable called `onesCount`.
1. If we encounter a `0` while counting ones then skip it and mark a flag that
we are ignoring zeros. Continue traversing the  array ignoring zeros.
1. If we encounter a `1` while ignoring zeros then we do not have a perfect
number.
1. When we've finished traversing and if `onesCount = 1+zerosCount` then we
have a perfect number.
'')''

and here's the code for this in python: 

''(code "python" ''

def isPerfect(n):
  bits = toBitsList(n)

  bitsLength = length(bits)

  zerosCount = 0
  onesCount = 0

  countingZeros = true;
  ignoringZeros = false;

  for i in length(bits):
    bit = bits[bitsLength - 1 - i]

    if countingZeros and bit == "0":
      zerosCount = 1 + zerosCount
    if not ignoringZeros and bit ==  "1";
      onesCount = 1 + onesCount
      countingZeros = false
    if not countingZeros and not ignoringZeros and bit == "0"
      ignoringZeros = true
    if not countingZeros and ignoringZeros and bit == "1"
      break

  return (onesCount == 1+zerosCount)


'')''

Often as programers we tend to forget how much information in the 
program is irrelevant to the problem at hand. Consider the python
code above. Here is all the extraneous information:

* a list
* the length of the list
* the current index in the list
* a flag for telling whether we're done counting `0`s on the right
* a flag for telling whether we're done counting `1`s.

At first glance this doesn't seem like a lot however, remember the 
problem statement:

''(r data.perfectNumDef)''

Here is the relavant information:

* any `10...01` pattern is invalid
* count of consecutive `1`s
* count of consecutive `0`s on the right

Notice how with the python code above we've _doubled_ the information we - the
programmer keep track of when writing this program. Furthermore I would argue
that this is what makes code un-readable. Typically the author of code writes
in a way that makes sense to them; all readers are at the mercy of how much
extra information they have to parse through in order to understand "what's
really going on". 

All code exists to solve some problem. The distance between understanding the
code at hand and understanding the problem that code was designed to solve
makes all the difference. That is, if I can clearly understand what problem is
being solved (with little-to-none prior context) directly from the code at hand
then I can say that the code was well written - and most likely easier to
maintain and safer.

I'd like to show how thinking like a functional programmer gets us closer to
writing cleaner code.

But first, monoids...

# Monoids

Consider the following tasks to perform with a program:

''(list [

"Finding the smallest number in a list"
"Finding the largest number in a list"
"Computing the sum of a list of numbers"
"Computing the product of a list of numbers"
"Converting a list of numbers into a string that is to be printed to stdout"
"Reversing a list of values"
"Checking if all values satisfy a predicate"

])''

Here's the pattern each solution to these problems will follow:

''(table ["Problem #" "Value If Empty List" "How to compute the result during each step of a loop"] 
  [ ["1" "`null`"  "`minVal = min(value, minVal)`"]
    ["2" "`null`"  "`maxVal = max(value, maxVal)`"]
    ["3" "`0`"     "`sum    = plus(value, sum)`"]
    ["4" "`1`"     "`prod   = multiply(value, prod)`"]
    ["5" "`""`"    "`str    = concat(str, toString(value))`"]
    ["6" "`[]`"    "`list   = concat(list, singletonList(value))`"]
    ["7" "`true`"  "`isAll  = and(predicate(value), isAll)`"]
  ]
)''

Do you notice a pattern? Each problem:

''(list [

''
Has a 'default' solution. This default value should be chosen so
as to not affect the outcome of the non-empty list case.
''

''
Possibly transforms each value to the same kind of value as the output. For
example in the last three the value is getting transformed into: a string, a
list, a boolean value.
''

''
Combines the possibly converted value with the current result using a function
that takes 2 arguments. If `a` were the type of the result of each problem then
the function of 2 arguments would have this type: `a <funcion-name-here>(x a, y
a)`.
''

])''

It turns out that mathematicians have gotten to this idea first. Things that
have a default value and a way to combine 2 values to produce a value of the
same type is called a monoid. 

A monoid is made of 3 things:

1. A type. I'll write this as `a`
1. A binary function (aka operator) of type `a -> a -> a`. That is it takes two
values of type `a` and returns a value of type `a`. I'll write this binary operator
as `◊`.
1. A default value of type `a` called the identity. I'll write this as `e`.

There are certain properties a monoid must obey. Let's discover these
properties together:

### Identity

First remember back to the problems above. Each one had a default value that
didn't affect the result if the list was non empty. For example the empty
string is the default value for creating a printable string because the empty
string has no effect when combined with other strings. Here's this property for all
the problems above:


''(table ["Problem #" "Value If Empty List" "How to compute the result during each step of a loop"] 
  [ ["1" "`null`"  "`min(value, null) = value`"]
    ["2" "`null`"  "`max(value, null) = value`"]
    ["3" "`0`"     "`plus(value, 0) = value`"]
    ["4" "`1`"     "`multiply(value, 1) = value`"]
    ["5" "`""`"    "`concat("", value) = value`"]
    ["6" "`[]`"    "`concat([], [value]) = [value]`" ]
    ["7" "`true`"  "`and(predicate(value), true) = predicate(value)`"]
  ]
)''

Do you notice the pattern? Each default value has no affect on the result of
the binary operator. Generally this is called the identity law and is written
as:

''(code "" ''
∀ x ∈ a
e ◊ x = x
x ◊ e = x
'')''
This means that every monoid's identity element `e` must obey the above
equations[^The `∀ x ∈ a` means "For all values in type `a`. And the variable
`x` represents these values).

### Associativity

Take the following list summation code. There's a hidden relationship between
the for-loop and the addition function. In order to see this we need to get
rid of the loop and the intermittant variables:

''(code "" ''

x = 0

for n in [3, 4, 5]:

  x = add(x, n)

'')''
First, unravel the intermittent values of x:

''(code "" ''

x0 = 0
x1 = add(x0, 3)
x2 = add(x1, 4)
x3 = add(x2, 5)

'')''

And then get rid of the intermittent variables by nesting the function calls:

''(code "" ''

add(add(add(0, 3), 4), 5)

'')''
The above code produces the same result as the for-loop, however with the
intermittant variables removed it's clear how the result of each `add` is being
re-used. Further more we could re-arrange the add calls so long as we keep the
order of the numbers. Since we're talking about monoids I'll use `◊` to denote
the binary operator of our monoid. In this case it's just the `add` function.

''(code "" ''

(0 ◊ 3) ◊ (4 ◊ 5) = add(add(0,3), add(4,5))
(0 ◊ (3 ◊ 4)) ◊ 5 = add(add(0, add(3,4)), 5)

'')''
Let's take the first example and write it using a for-loop:

''(code "" ''

x = 0
for n in [3]:
  x = add(x, n)

y = 0
for x in [4,5]:
  x = add(x, n)

x = add(x, y)

'')''
`(0 ◊ 3) ◊ (4 ◊ 5)` would translate to taking a list, splitting it in half -
summing each half and then adding the results. What this means is that we 
can distribute the summation across multiple threads. And no matter how we
distribute the problem we will always get the same result.

There is an equation that states this in more precise terms:

''(code "" ''
∀ {x,y,z} ⊆ a

x ◊ y ◊ z = x ◊ (y ◊ z) = (x ◊ y) ◊ z

'')''
This means that for any values of type `a` we can run the binary operators in
any order and still get the same result. 

# Redesigning With Monoids

Let's look at how we can solve the above problems using monoids. First we'll
tackle the printable string problem. Here's the python code for reference:

''(code "python" ''

def toPrintableString(numList):
  
  str = ""

  for n in numList: 
    if str == "":
      sep = ""
    else:
      sep = ", "

    str = str + sep + toString(n)

  return str

'')''

''(code "python" ''

# String -> String -> String
def combineSepStr(a, b):

  if a == "" and b == "":
    return ""
  else if a == "":
    return b
  else if b == "":
    return a
  else:
    return a + ", " + b

def toPrintStr(numList):

  # identity of strings
  res = ""

  for n in numList:
    combineSepStr(res , toString(n))

  return res

'')''


# A Monoid for Perfect Numbers

Let's design a monoid that will be used to tell whether a number is a perfect
number. We'll bounce back and forth between defining the binary operator 
and the elements of our set.

Remember the bit pattern of a valid perfect number: `0...111...000` where if we
have `m` ones in the middle then we can have `m-1` zeros on the right and any
number of zeros on the left. One way to determine if a binary number follows
this pattern is to collapse repeating bits together while keeping track of
their count. For example:

```
111  → (1,3)
0000 → (0,4)
```
where the first element tells us which bit is repeating and the second element
gives us how many times it was repeated. So a binary number can be re-written
as a sequence of these pairs. For example:

```
11001110 ↔ (1,2) (0,2) (1,3) (0,1)
```

Another way we could have written the above is: 

```
11001110 ↔ (1,1) (1,1) (0,1) (0,1) (1,1) (1,1) (1,1) (0,1)
```

So since we have 2 ways to write the same binary number as a sequence of tuples
wouldn't it make sense to say that there's a "simplest" representation? And
could re-reduce a sequence of tuples into its simplest form? Yup!  This means
that `(1,1) (1,1)` is the same as `(1,2)`  both come from the binary number
`11`. And notice how the simpler form `(1,2)` can be constructed by adding the
second number in the tuple. We have now discovered a way to combine to things!
This smells like a monoid! 

So what's the set of our monoid? Well, what are we combining? Bit count tuples
we'll represent their type as `(Bit, Natural)`. This means "the set of all
pairs of a bit and a natural number. 

Next our binary operator is `(*) : (Bit, Natural) -> (Bit, Natural) -> (Bit,
Natural)`.  And our first definition of the `*` operator is:

```
''{monoid1 = 
  ''
  (1, n) * (1, m) = (1, n + m)
  (0, n) * (0, m) = (0, n + m)
  '';
}''
```

That is if we have 2 tuples adjacent to each other and their bit's are the same
then we can combine them together and form another tuple by just adding the two
natural numbers. 

We're partway done creating our monoid. Now we need to worry about 2 things
converting binary numbers into our monoid element sequence and then defining
the rest of our `*` operator to only allow a successful value if the binary
number follows our pattern.

We've already handled the case in mapping bits to our tuple form.  Here's that
function:

```
0 → (0, 1)
1 → (1, 1)
```

Now remember the first law, the output of our binary operator needs to be able
to re-use its outputs.

```
''(r data.monoid1)''
(1, n) * (0, m) → ((1,n), (0, m))
(0, n) * (1, m) → ((0, n), (1, m))
((0, n), (1,n)) * ((1, o), (0, p)) → ((0, n), (1, n + o), (o, p))
```

'']
