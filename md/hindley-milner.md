---
title: Hindley-Milner Type System
tags:
  - type-system
  - programming
  - languages
  - lambda calculus
---

# Intro 

The Hindley-Milner type-system is an alternative approach to adding
polymorphism to the simply typed lambda calculus. [1] defines what
they simply typed lambda calculus is. 

One of the major problems with the simply typed lambda calculus and System-F is
that we have to add explicit type-annotations to every lambda: `λ x:T . L` is
the new syntax for lambdas. While this is useful in guiding the type inference
algorithm it leave the programmer with so many annotations that it becomes
cumbersome. Hindley-Milner fixes this problem by altering the type language and
term language.

# Syntax

## Terms

  ```
  T := 
      c 
    | x 
    | λx . T
    | T₁ T₂
    | let x = T₁ in T₂ 
  ```
Why the `let` binding? Well, consider if we didn't have it and instead it was
syntax sugar:

  ```
  let x = T₁ in T₂ ⇒ (λx . T₂) T₁
  ```
Now I'm stuck and have no clue because this seems to work...

## Types

  ```
  τ := 
      α 
    | C [τ]

  σ :=
      τ
    | ∀ α . σ
  ```
where `C` is a set of constructors. And `[τ]` are the types to apply to the
constructor.

  * Constant types (like N) are `C []` types (a constructor with no type
    arguments).
  * Polymorphic types (like Maybe) are `C [τ]` types (a constructor with 1 type
    argument)
  * `→` type is a `C [τ₁, τ₂]` type.


Notice, this is 

[1]: ./md/simply-typed-lambda-calculus.md 
