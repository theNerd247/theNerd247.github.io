---
title: Kinds, Types, and Terms
tags: 
  - lambda calculus
  - type theory
---

# Relationship between Terms, Types, and Kinds

I've been observing:
  
  * terms' syntax is described by the untyped lambda calculus.
  * terms by themselves are untyped
  * types by themselves are unkinded
  * kinds by themselves are unsorted
  * ...

term ⇒ types ⇒ kinds

n   | `xⁿ` term | `xⁿ⁺¹` term
--- | ---       | ---
0   | term      | types
1   | types     | kinds
2   | kinds     | sorts
3   | sorts     | ...

Each of these layers has a relationship to the one above it through the
relation: `xⁿ :ⁿ xⁿ⁺¹`. 

  * Can this relation be made universal? Is the following statement true?

    ```
    ∃ : | ∀n ∈ N. :ⁿ = :
    ```
  * Is this a bad idea?  
For the simply typed lambda calculus: 

`:¹   ≡ : T`
`:ⁿ≥¹ ≡ : ()`

# `n` Term Language   

Each `:ⁿ` is determined by the language of the right side terms. For example
for the simply typed lambda calculus: 

```
terms ≡ c | x | λx.L | x y (where c is a set of value constants)
types ≡ T := C | (→) T₁ T₂ (where C is a set of type constants)
kinds ≡ *                  (a single term)
```
So the relation `:` would be: 

```
:⁰ ≡ c : C | x : T | (λx.L) : (→) T₁ T₂ | x y : T
:¹ ≡ T : *
```
