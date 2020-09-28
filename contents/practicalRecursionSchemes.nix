conix: { posts.practicalRecursionSchemes = with conix.lib; postHtmlFile "practicalRecursionSchemes" "" (textsd [

{ tags = ["recursion-schemes" "functional-programming"];  draft = true;}

''
# ''(label "title" "Practical Recursion Schemes")''

I'm obsesed with recursion schemes. And I'd like to give a practical example of
what they are and why they are practical. For now I'll stick only to 1
recursion scheme - catamorphisms (aka folds or, for the JS folk, a more generic
`reduce`).

## Searching Through Trees

Let's say you have a tree that stores words of a sentence.

''(dotDigraph "substrTree"
''
digraph {
  a -> b
  b -> e
  a -> p
  p -> e
  a -> n
  n -> t
}
'')''

'']);}

