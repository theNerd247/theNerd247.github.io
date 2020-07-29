---
title: evaluation via recursion-schemes
tags:
  - lambda calculus
  - recursion-schemes
  - Haskell
  - programming
  - languages
---

Evaluation by normalization can be done using recursion schemes:

```
data TermF a = ...
data ValueF a = ...

type Value = Fix ValueF

type Ctx = [Value]

eval' :: Alg TermF (Ctx -> Value)

quote' :: Alg ValueF (LambdaCount -> Term)

eval :: Term -> Term
eval = ($0) . cata quote' . ($[]) . cata eval'
```

See [1]

[1]: ./2017102.md
