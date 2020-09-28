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

data STree = Root Char [STree]
  deriving (Show)

type SWord = String
type RWord = Maybe String

findWord :: SWord -> STree -> RWord
findWord sWord = fmap reverse . findWord' Nothing sWord

findWord' :: SWord -> RWord -> STree -> RWord
findWord' [] rWord _ = rWord
findWord' sWord@(s:ss) rWord (Root c branches)
  | s == c           = firstRword $ findWord' ss (rappend s rWord) <$> branches
  | rWord == Nothing = firstRword $ findWord' sWord rWord <$> branches
  | otherwise        = Nothing

firstRword = getFirst . foldMap First

rappend s Nothing    = Just $ s:[]
rappend s (Just str) = s:str
```

'']);}

