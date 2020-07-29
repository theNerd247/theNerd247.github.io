---
title:
tags:
  - lambda-calculus
  - types
  - polymorphism
  - system-f
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
  nothing : T₂ → (T₁ → T₂) → T₂
  just    : T₁ → T₂ → (T₁ → T₂) → T₂

  Kinds
  nothing : *
  just    : *
  ```
We have a problem. What do we put down for `T₁`? This is the type of the
thing we're storing in the `Maybe`. For example `T₁` could be `Int` and then
`just 2 : Maybe Int``Maybe` in the general sense works for any time `T₁`
(should be polymorphic)! If we are sticking to simply typed lambda calculus[^1]
then this is not possible because we don't have type-level lambdas[^2].

There's another problem. What do we put for `T₂`? This is the type that a
`Maybe T₁` should evaluate to. Well...

  ```
  t := … | λx:T.t | …
  ```
So. a `Maybe Int` would be written as:

  ```
  λx:Int n:Int j:(Int → Int). j x
  ```
Now what if we really want polymorphism? Then we'd need to extend to using System-F.

  ```
  ∀a.∀b.λx:a n:b j:(a → b) . j x 
  ```
Here we don't explicitly state the type of the inputs. Instead we put a type
lambda (`∀`) that turns the 3 variable `just` into a 5 variable function. The
extra 2 variables at the beginning are type variables that are used to form the
types of the incoming terms.

[^1]: We're actually using the untyped lambda calculus where `c := {()} ∪ N` -
  constants are the unit value and the natural numbers.
[^2]: Put another way these are like adding `λ` terms to the type language of
  the simply typed lambda calculus.

[1]: ./simply-typed-lambda-calculus.md
