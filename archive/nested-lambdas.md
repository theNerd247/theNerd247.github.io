---
title: nested lambdas
tags:
  - lambda-calculus
  - programming
  - langauges
  - functions
---

In lambda calculus the only construct for functions are single variable lambdas. But in the realworld we often want to use functions that take in multiple inputs. This can be done in lambda calculus by leveraging a simple fact: lambdas can construct new lambda terms. 

Here's how:

```
λx . x + 1
```
Is a lambda(1) expression that adds 1 to the given input `x`. But what if I want to model `+` which is a 2 variable function in lambda calculus? Here's how:

```
λx . λy . x + y
```
We create an normal lambda term that returns another lambda term which in turn computes the sum of the first and second inputs. Let's take this step by step by applying only a single value to the outer lambda:

```
  (λx . λy . x + y) 2 
⇒ λy . 2 + y
```
we get back another lambda with each occurance of `x` replaced with the input value `2`. Continuing this story, let's apply second variable to the generated inner lambda:

```
  (λy . 2 + y) 3
⇒ 2 + 3
⇒ 6
```
Here we replaced every occurence of `y` with `3` and get back the expression `2 + 3` which then evaluates to `6`.

To be succinct we typically place the variables of nested lambdas side by side like this:

```
λx . λy . x + y
λx y . x + y
```
which looks more like the way we write it in algebra!

---

1. Technially we're using  the lambda calculus extended with arithmetic to make it easier to read.
