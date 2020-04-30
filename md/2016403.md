---
title: lambda calculus applications
tags:
  - lambda-calculus
  - application
  - functions
  - programming 
  - languages
---

Lambda calculus has syntax for function application:

```
T₁ T₂
```
where `T₁` and `T₂` are lambda calculus terms that __must be seperated by spaces__.

Here are a few examples:


```
(λx.x) y
y (λx.x)
(λz.x) (y (λa.λb.b))
```

Note. We use parenthesis when writing multiple applications together. To avoid extraneous use of parenthesis we assume applications are left associative:

```
x y z ≡ (x y) z ≠ x (y z)
```
