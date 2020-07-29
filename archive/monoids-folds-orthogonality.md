---
title: Monoids and Folds The Orthogonality
tags:
  - functional-programming
  - monoids
  - data-structures
---

# Monoids

Monoids are:

  * order independent when combining
  * contains an initial value that can be thrown away
Mathematically they are implemented as:

  * a set M 
  * a function `<>` that is associative
  * an identity element such that :

    ```
    ∀a ∈ S. ∃e ∈ S. a <> e = e <> a = a`
    ```
Monoids can be defined as a category[1].

# Foldable

A foldable is a datastructure that we can collapse into a single value.
Typically things like skipping elements, order in which the data structure is
collapsed, early termination etc. are handled per-datastructure. For example
a tree could do breadth first or depth first folding. 

# Orthogonality

Because monoids don't care about the order in which you collapse application of
`<>` (by the associativity law)[^1]:

  ```
  (a <> b) <> c = a <> (b <> c)
  ```

[^1]: Note this doesn't mean `a <> b = b <> a`. This equality means `<>` is
  commutative and implies the order in which elements are applied to the
  operator doesn't matter.

[1]: ./monoid-category.md

