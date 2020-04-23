---
title: church numerals
tags:
  - lambda-calculus
  - programming
  - languages
---

Church numerals are the lambda calculus encoding of the natural numbers:

```
zero := λf.λx.x                 (0 applications of f to x)
succ := λn.λf.λx.n f (f x)      (add 1 application of f to x in given numeral)

1 := succ zero
2 := succ (succ zero)
3 := ...
```

Addition, subtraction, and multiplication can all be encoded as lambda calculus terms.
