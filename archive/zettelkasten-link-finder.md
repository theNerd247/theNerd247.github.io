---
title: Algorithm for Finding Potential Relations Between Notes
tags:
  - algorithm
  - zettelkasten
  - graphs
---

# Algorithm

`ConnectKeyword :: Notes -> Notes`

1. Take notes and form a graph `Graph Note`
1. Insert edges formed via tags.
1. Gather all pairs of nodes in the graph that satisfy the unreachable
   relation.
1. Filter those nodes down with a keyword search relation:

  * search should ignore common english words
  * by the second step this search will ignore tags that don't already relate
    the nodes. But tags that do not already relate the nodes should still be
    included in the search.
  * search result should include pair of note URIs and a set of common tags not
    already in common.
  * search should account for count of keywords in documents to determine
    strength of search
  * search should ignore:
      
      * code blocks
      * links
      * headers? 
      * images
  * search should NOT ignore
      
      * main text blocks (paragraphs)
      * footnotes / margin notes
      * inline texts
      * image captions
1. Present search results to user and allow manual filtering.
1. Generate document entries for each search result 
1. Modify respective files for each generated document entry

# Properties

1. `ConnectKeyword Notes = Notes | Graph(Notes) is connected`
1. `ConnectKeyword Notes = Notes | User input is ignored`

# Notes

It might be useful to write seperate algebras for solving different pieces of
the puzzle namely:

  * collecting links from a note
  * collecting keywords from a note
