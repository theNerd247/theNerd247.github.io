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

Take the following sequence of numbers: `1,3,5,7,9`. We can perform the
addition of these numbers in any order:

''(list 
[ "`(1+3) + (5+7) + 9`"
  "`1 + (3+5) + (7+9)`"
  "`1 + (3 + (5+7) + 9)`"
  "`(((1+3) + 5) + 7) + 9`"
])''

to name a few. Addition also comes with a special number called the identity
number that doesn't change the result of addition. It's `0`. `0 + n = n` and `n
+ 0 = n`. And finally, notice that we can re-use the result of an addition to
perform another addition.

It turns out that these 3 properties are everywhere in our world:

''(list [

  "multiplication"
  "concatenating strings"
  "mixing paint"

])''

And there's the common pattern between all of them. Each addition like thing
is:

  * A set of elements (e.g. numbers, paints, etc.)
  * An binary operator (e.g. addition, multiplication, mixing 2 paints, etc.)
  * An identity element (e.g, `0`, `1`, laquer - a transparent paint)

These things are 
In math these 3 things together is called a monoid. And each monoid must behave
in the following manner:

  1. The binary operator can only output elements in the given set.
  Mathematically this is called a closed operator. In computer science we write
  the type of such functions as `(*) : a -> a -> a`. This means that the `*`
  operator takes in 2 elements of type `a` and produces a value of type `a`.
  Here `a` represents the set of all values of type `a`. Taking addition as a
  more concrete example consider the binary operator `+`. It's type is `(+) :
  Natural -> Natural -> Natural`.  That is it takes 2 `Natural` numbers and
  produces a value that is a `Natural` number. At first glance this property
  is pointless - however it'll come into play later on.

  1. The order in which combination is executed doesn't matter. Mathematically
  this is called the associativity law. Typically this statement is written
  down in equation form. That is if the combination order doesn't matter then
  for all `a`, `b`, and `c` elements of a set the following equation always
  holds:

    ```
    a * (b * c) = (a * b) * c
    ```
  where `*` is the binary operator of the monoid.

  1. The identity element is a right and left identity of the binary operator.
  Again in equation form:

    ```
    e * a = a
    a * e = a
    ```
  where `e` is the identity element of the monoid and `a` any element in the
  monoid.

There are a few things that aren't quite so obvious from the definition alone
but are extremely useful when inventing a monoid. First, the binary operator
preserves the order of the elements being combined.

Remember the list of numbers above? The monoid being used there was the natural
numbers (numbers 0,1,2,...) with `+` and `0` as the binary operator and
identity element. When we add 3 numbers together (say `1 + 3 + 5`) the monoid
laws says we are free to perform the addition in any order we like but there is
no law that says it's ok to re-arrange the numbers. For addition this doesn't
make much sense because naturally addition does allow us to re-arrange the
numbers, however with string concatenation this is more obvious. For example:

```
"fire" * "fly" = "firefly" != "fly" * "fire" = "flyfire"
```
Here it makes no sense to say that we can re-arrange the order in which strings
are concatenated. Practically this law allows us to "not care" about the data
structure storing the elements of our monoid. That is if I give you a list of
numbers to add verses a JSON object or maybe some C# iterator object. As long
as the order in which the elements are presented to the `+` operator are the
same we will always get the same result. This plays an important role in
developing clear thinking about the problem at hand.

The second non obvious thing is that results from applying a binary operator 
must always be re-useable. This is what the first law states. While this may
seem trivial it is important to keep in mind when creating a new monoid.

Finally the third law gives us the ability to construct "default" results.
Consdier our addition example. What number should we give if we had an empty
list of numbers to add? Naturally we would say `0`. But why? Well, consider
multiplication. If we were multiplying a list of numbers instead of adding them
then when given the empty list we would return 1. And for strings, we would
return the empty string. The reason we are picking these particular values is
because they are the identity element. And the identity element behaves in such
a way so as to dissapear when 1 or more elements in the set need to be
combined. When the identity element is partially applied to the binary operator
we get the identity function - a function that does nothing with its argument
except returns it.

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
