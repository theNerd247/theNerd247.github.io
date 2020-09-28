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
  node0 [ label = "a" ]
  node1 [ label = "n" ]
  node2 [ label = "t" ]
  node3 [ label = "p" ]
  node4 [ label = "e" ]
  node5 [ label = "t" ]
  node6 [ label = "d" ]

  node0 -> node1
  node1 -> node2 
  node0 -> node3
  node3 -> node4
  node0 -> node5
  node1 -> node6
}
'')''

'']);}

