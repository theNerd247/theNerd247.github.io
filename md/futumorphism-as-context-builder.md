---
title: futumorphism as context builder
tags:
  - programming
  - recursion-schemes
  - evaluator
  - haskell
---

We often have an algebra `F (c -> a) -> (c -> a)` for doing bottom up
evaluation and passing information from the parent nodes down to their
children. This tends to creates problems in that one cannot optimize and ignore
results of grand-children nodes because they are wrapped in a function. For
exmaple

```
λ.e ⇒ t
e := t 0

TermF (Ctx -> Value) -> (Ctx -> Value)
((LambdF e)) = eta <$> e
  where
    eta (x -> VApp e (VVar (Local 0))) = e
```
η reduction is an optimization when performing top-down evaluation. We can skip
evaluating the term `0` and simply reduce to `t` as we go down the tree. This
saves in better maintaining lazy evaluation. 

However the `eta` optimization isn't really an optimization because it's done
AFTER the values are constructed.

One could argue that it's a `quoting` optimization because we reduce the number
of recursive calls needed. But can't we avoid generating needless values that
are only thrown away in the long run?

A better option maybe to use a futumorphism [1]? Or something akin to a
histomorphism but for going down...


  ```
  Remember c f a = Compose ((c,)) f a

  (Ctx, Term) -> Remember Ctx TermF (Ctx, Term)
  ```
where the `(c,)` functor (in the right argument) holds a cache of the seed that
that was given to that node from the parent.

[1]: 2016502.md
