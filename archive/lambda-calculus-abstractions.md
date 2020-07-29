---
title: lambda calculus abstractions
tags:
  - lambda-calculus
  - functions
  - abstractions
  - programming 
  - languages
---

Lambda calculus has syntax for a type of nameless functions called abstractions.

```
λx.T
```
where `x` is called the _head_ and `T` is called the _body_.

Some sample abstraction expressions include: 

```
λx.x    (identity function)
λx.λy.x (const function)
λf.x.x  (Church numeral zero / Boolean false)
```
