---
title: Arrays in C
tags: 
  - programming
  - c
  - datastructures
---

Arrays in the C programming have always been a softspot for me. They're simple
when you understand basic computer memory models and fun to play with once
you've learned pointers. Here's a few facts you need to keep in mind.

  * There is no empty array in C
  * All arrays must have a predetermined C given to them at compile time[^1].
  * Elements of an array must be of the same memory size. I avoid saying "type"
    because in C we think in terms of the computer memory model not types from
    type theory. As such an `int[]` could very well contain `bool` values due
    to casting.

The first element of an array is stored in a memory cell with a particular
address (we'll call `a ∈ N`). The second element in the array is stored at an
adjecent address (`a+1`). The empty array doesn't exist in C.

[^1]: Ok, not ALL...but most. This touches on dynamic vs static memory...and I
  don't want to get into this right now.
