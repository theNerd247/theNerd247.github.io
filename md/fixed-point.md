---
title: Fixed Point
tags:
  - recursion
  - lambda-calculus
---

A fixed point of a function `f` is an input value `a` where `a = f(a)`. That is
the function doesn't modify this value. Often fixed points can be found by 
repeatedly applying a function to itself. In programming tend to find fixed points
by continuously calling a function on itself.

  ```
  fix :: (a → a) → a
  fix f = f (fix f)
  ```
