---
title: F-Algebras and Recursive Types
tags:
  - recursion-schemes
  - programming
  - f-algebras
  - haskell
---

An F-Algebra is a 3-tuple of categorical objects: 

  * an endo-functor `F : C ⇒ C`
  * a carrier object `a ∈ Obj(C)`
  * an evaluator morphism `f ∈ Hom(C) : F a → a`

Recusive types can be encoded as the fixed point of the functor F. Where `Fix` represents
a type constructor with kind `Fix : (* → *) → *`[^1]: 

  ```
  newtype Fix f = {unFix :: f (Fix f)}
  ```
Lists can then be defined as: 

  ```
  ListF e a
    = NilF
    | ConsF e a
    deriving (Functor)

  type List' a = Fix (ListF a)
  ```
Notice how the `ListF` is a non-recursive functor wherer we put a hole where
the recusive parts are supposed to go. Also by doing this we can see that every
List must terminate at some point because `NilF` is a constructor of `ListF` that
takes no recursive-hole arguments `a`.

[^1]: Notice the kind of `Fix` is the same as the type for the value-level function `fix`

[1]: ./fixed-point.md
