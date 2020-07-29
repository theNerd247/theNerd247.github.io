---
title: Yoneda Lemma
tags:
  - category-theory
  - yoneda-lemma
  - Haskell
  - draft
---

# Morphisms Define The Objects

First, thinking of cateogries as a formal way to reason about the language
of math is very helpful[2]. The Yoneda Lemma formalises this concept.

# Sets as the Foundation of Mathematics

The language of sets is a the foundations of mathematics. In fact it is very
natural to think in terms of how sets relate to each other. So then if a
language (category) can be translated in to the language of sets then we can
get insight into that category. To put it another way: sets are very concrete.
It's easy to visualize a set and mapping elements in one set to elements in
another. So by providing a functor from a category to Set then we can give a
more concrete representation of that category.

# A Functor Representing an Object

Many mathematical objects are never given a definitions that are inherent to
themselves. For example: numbers are not defined as being just numbers. You
can't walkup to a mathematician and just say "a number is a number is a number;
the end". Instead a number would be defined in terms of how it relates to other
concepts in the same language. The set of numbers is defined by how it relates
to other sets.

This pattern shows up a lot in other areas of human thinking. So is there a way
to formalize this? Yes! That's something category theory is good at doing. 

Every object in any category[^1] can be mapped to the category of Set (which,
by the way, is a _very_ concrete category). That is there exists a functor
`Ya : Cop -> Set` that maps a category `C` to `Set`. Here's it definition:

  ```
  Ya : Cop -> Set

  Ya(x) := { f : x -> a | f ∈ Morph(C), x ∈ Obj(Cop) }

  Ya(m) := { g : (x -> a) -> (y -> a) | m : y -> x, m ∈ Morph(Cop) }
  ```
In English: `Ya` maps objects to sets of morphisms that point at some selected
object `a`. `Yb` would be the samething but for a different object `b`. So we
now have a formal way of stating what it means for a single object to relate to
everything around it. `Ya` goes by another name: "the functor representing a in
C". That is `a` can be defined by a functor which relates `a` to every other
object in the category.

Here's an example. Let's consider `Cop := Setop` and `a` will be the set of boolean 
values:

  ```
  bool = {true, false}
  ```
so `Ybool : Setop -> Set`.  What is the functor representing `bool`, that is
what is `Ybool({1,2,3})`'s definition?:

  ```
  Ybool({1,2,3}) := { f1, f2, f3, ..., f8 } (there 2^3 functions going from {1,2,3} to bool)
  ```

[^1]: Well, almost any...we'll stick to categories for which the above holds
  true.

[^2]: You might be wondering: Why `Cop` instead of `C`. This has to do with
  contravariant versus covariant functors. We tend to think in terms of
  covariant functors and so instead of saying "A contravariant functor from `C`
  to `Set` we instead say "A covariant functor from `Cop` to `Set`. They mean
  the same thing.
 
[1]: ./category-morphisms.md
[2]: ./language-category-theory.md 
