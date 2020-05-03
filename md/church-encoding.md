---
title: Church Encoding
tags: 
  - lambda-calculus
  - datastructures
  - programming
---

Church encoding is the idea that data structures can be modelled as functions
in the lambda calculus. The trick is to change how we view what a datastructure
is used. Normally we would say it's something that stores data for a purpose.

Church encoding says datastructures are a collection of functions that define
what to do with that data. Take a list, for example. A list is a finite
collection of things in a linear order. In C this is modelled closely to how
the computer is physically wired[^1]

[^1]: For the curious this is done using pointers [1]. 

[1]: ./arrays-in-c.md
