---
title:
tags:
  - lambda-calculus
  - types
---

So in Haskell `Maybe` is a type. `Maybe : * → *` is the relation between
`Maybe` the type and it's kind (`* → *`). But, what if we didn't have 
function kinds? 

Currently the kind language is:

  ```
  kinds ≡ k := * | (→) k k
  ```
But what if we want `k' := *`? What happens to `Maybe`? 

Well ... let's start with terms and reconstruct maybe in the untyped lambda
calculus[^1]. Then we'll add on types, then kinds and see where this leads us.
First, we don't have a language yet for data constructors so we'll need to 
use church encoding for our data constructors.


  ```
  Terms
  nothing :=   λn j. n
  just    := λx n j. j x

  Types
  nothing : T₁ → T₂ → T₁
  just    : T₁ → T₂ → (T₁ → T₃) → T₃

  Kinds
  nothing : *
  just    : *
  ```
We have a problem with the above types. In the simply typed lambda calculus `:`
is part of the language of terms:

```
t := … | λx:T.t | …
```
So every term must be assigned a type. But which types? Any type? No, only
types that are concrete. This is the simply typed lambda calculus doesn't allow
for `∀a. T a` types [1].


[^1]: We're actually using the untyped lambda calculus where `c := {()} ∪ N` -
  constants are the unit value and the natural numbers.

[1]: ./kinds-values-types.md
