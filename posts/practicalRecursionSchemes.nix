conix: { posts.practicalRecursionSchemes = with conix.lib; postHtmlFile "practicalRecursionSchemes" "" (textsd [

{ tags = ["recursion-schemes" "functional-programming"];  draft = true;}

''
# ''(label "title" "Practical Recursion Schemes")''

I'm obsesed with recursion schemes. And I'd like to give a practical example of
what they are and why they are practical. For now I'll stick only to 1
recursion scheme - catamorphisms (aka folds or, for the JS folk, a more generic
`reduce`).

## Searching Through Trees

A search tree stores words of a senence in alphabetical order. Below we have a
tree storing: "ant", "and", "ape", "at":

''(dotDigraph "substrTree"
''
digraph {
  node0 [ label = "a" ]
  node1 [ label = "n" ]
  node2 [ label = "t" ]
  node3 [ label = "p" ]
  node4 [ label = "e" ]
  node5 [ label = "t" ]
  node6 [ label = "d" ]
  node7 [ label = "y" ]

  node0 -> node1
  node1 -> node2 
  node0 -> node3
  node3 -> node4
  node0 -> node5
  node1 -> node6
  node6 -> node7
}
'')''

To search for a word we'll use the following algorithm where:

`sWord` 
: the current word being searched
: initially set to be the substring to search for

`sLetter`
: the first letter of a non-empty sWord

`rWord`
: maybe the current matching word being constructed.
: initially set to be Nothing.
: When appending a letter to an rWord Nothing is treated as the empty string.

''(dotDigraph "searchAlg1"
''
digraph {

  node0  [label = "sWord empty"]
  node1  [label = "return rWord"]
  node2  [label = "Root matches sLetter?"] 
  node2b [label = "Append sLetter to rWord"]
  node3  [label = "Pop sLetter from sWord"]
  node4  [label = "Recurse on all branches"]
  node5  [label = "Return first rWord"]
  node6  [label = "rWord Empty?"]
  node8  [label = "Return empty rWord"]

  node0 -> node1 [label = "yes"]
  node0 -> node2 [label = "no"]
  node2 -> node2b

  node2b -> node3 [label = "yes"]
  node3 -> node4
  node4 -> node0
  node4 -> node5

  node2 -> node6 [label = "no"]

  node6 -> node4 [label = "yes"]

  node6 -> node8 [label = "no"]
}

'')''

And here's some haskell code to demonstrate this:


```haskell

import Data.Monoid (First (..))

data STree = STree Char [STree]
  deriving (Show)

type SWord = String
type RWord = Maybe String

findWord :: SWord -> STree -> RWord
findWord sWord = fmap reverse . findWord' Nothing sWord

''(label "findWordCode" ''
findWord' :: SWord -> STree -> [RWord]
findWord' [] tree = collectWords tree
findWord' sWord@(s:ss) (STree c branches)
  | s == c           = foldMap ((c:) . findWord' ss) branches
  | otherwise        = []
'')''

collectWords :: STree -> [RWord]
collectWords (STree c branches) = foldMap ((c:) . collectWords) branches

```

## Recursion Schemes

### Defunctionalization

The idea behind recursion schemes follows a similiar idea of
defunctionalization. So I'll cover that first.

Defunctionalization is the technique of replacing a function with a
datastructure. The idea is that the programmer can bind arguments to a function
without actually evaluating that function and then later convert that
datastructure into a value. Converting that datastructure into a value is the
same as just evaluating the original function with arguments.

Here's an example:

```haskell

isSumEven :: Int -> Int -> Bool
isSumEven x y = (x + y) `rem` 2 == 0

foo :: Bool
foo = isSumEven 2 3
```

`isSumEven` can be defunctionalized to:

```haskell
data Expr where
  IsSumEven :: Int -> Int -> Expr

apply :: Expr -> Bool 
apply (IsSumEven) = (x + y) `rem` 2 == 0

foo :: Bool
foo = apply (IsSumEven 2 3)
```

Notice how `foo`'s definition is replaced. Instead of calling `isSumEven` it
first constructs an `Expr` value and then deconstructs that value using
`apply`.

In silly examples like this there's no point to defunctionalization, however,
it's power comes in when you want to:

  * Serialize / Deserialize functions over HTTP
  * optimize your code by manipulating which functions are called and when
  * clarifying complicated recursive code.

The last bullet is what we'll focus on from here out. We are going to take the
recursive tree code from above and re-write it so that we don't have to write
complex recursive functions.

### Recursive Defunctionalization

Recursive functions are tricky and are not as straight forward to
defunctionalize as non-recursive functions. However, I've discovered a few
techniques. First, recursive functions are unique to their use cases. Here's a
list of questions to ask yourself when writing the 

The answers to the last 2 questions we can find by analyzing the recursive code
above:

```haskell
''(t conix.posts.practicalRecursionSchemes.findWordCode)''

```

Here's the recursion-scheme code:

```haskell

newtype Fix = Fix { unFix :: f (Fix f) }

cata :: (Functor f) => (f a -> a) -> Fix f -> a
cata alg = c where c = alg . fmap c . unFix

data ListF e a
  = Nil
  | Cons e a
  deriving (Functor)

type List e = Fix (ListF e)

type SWord = List Char

type RWord = List Char

nill :: List e
nill = Fix Nil

cons :: e -> List e -> List e
cons e l = Fix $ Cons e l

data STreeF = STree Char [a]
  deriving Functor

data STree = Fix StreeF

newtype SearchF a = 
    SNil (STreeF a)
  | SCons Char ???
  deriving Functor

findWordAlg :: SearchF [RWord] -> [RWord] 
findWordAlg (SNil (StreeF c rwords))    = cons c <$> rwords
findWordAlg (SCons s (StreeF c rwords)) = 

```

'']);}

