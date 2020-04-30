---
title: futumorphisms
tags:
  - programming
  - recursion-schemes
  - evaluator
  - haskell
---

Futumorphisms are for enabling one to skip a Functor generating step during top down construction and only produce the next seed.

  ```
  CoAttr f a 
    = CVal a 
    | CNext (f (CoAttr f a))
    deriving Functor
  ```
