---
title: normalisation by evaluation
tags:
  - lambda calculus
  - evaluation
  - functional-programming
  - programming
  - languages
---

Normalisation by Evaluation(1) is an evaluation strategy that involves
translating terms to a different representation and then translating back.


```
Concrete Representation (T := Var Nat | Lam T | App T T)

    │         ↑
 interpret  quote
    ↓         │

Semantic Representation (S := Lam (S -> S) | Syn S)
```

Note how `T` matches the canonical representation of lambda terms in Haskell.
But the Semantic representation defines what evaluated terms mean or represent
(lambda terms represent functions in Haskell). 

Looking deaper at `S` why don't we have application? Applications represent the
reducing a function with a given argument at some point in the evaluation. The
only application terms that make sense are ones where the left side is a lambda
term (the right side can be any term) - this is fact enforced by the type
system. So when evaluation time comes we know that every application will have
a lambda on the left and so the meaning of an application will be equivalent to
the meaning of the expression inside the lambda.

```
l := λx . T : A → B 

meaning of l ⇒ (l' : S -> S)

l (y : A)

meaning of l (y : A) ⇒ meaning of T ⇒ T' : S 
```

(1): [See wiki link](https://en.wikipedia.org/wiki/Normalisation_by_evaluation)
