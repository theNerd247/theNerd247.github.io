---
title: Church Encoding - Folds of Datastructures
tags: 
  - lambda-calculus
  - datastructures
  - programming
---

Church encoding is the idea that data structures can be modelled as functions
in the lambda calculus. The trick is to change how we view what a datastructure
is used. Normally we would say it's something that stores data for a purpose.

Church encoding says datastructures are a collection of functions that define
what to do with that data. Take a list, for example. A list is a finite
collection of things in a linear order. In C this is modelled closely to how
the computer is physically wired[^1]. In Haskell a list is defined recursively
as:

  ```
  List a = Nil | Cons a List

  Nil : List a
  Cons a : a → List a → List a
  ``` 
`Nil` is the empty list, and `Cons` stiches an element (called the "head") of
type `a` to another list (called the "tail"). Both the C and Haskell ideas of a
list only discuss the structure of the data in the list. 

But data that's just sitting around is useless. It's like having a bunch of
parts to a car without ever building it - useless. And that's the idea behind
Church encoding. Here's the Church encoding for lists:

  ```
  ListC a b = b → (a → (ListC a b) → b) → b
  ```
It's a function! A function with 2 arguments: one for each constructor from the
Haskell list:

  ```
  ListC a b 
    -- the value to return if we have a null list
    = b  
    -- the function to run to get a return value from the head and tail of the
    -- list
    → (a → b → b) 
    → b
  ```
`Nil` and `Cons` can then be re written as:

  ```
  nil = \b f -> b
  cons x xs = \b f -> f x (xs b f)
  ```
Notice how the recursive reference for the `List` in the original definition
gets replaced with a type variable `b` in `ListC`[^2]. This `b` type represents
the type of value the list will eventually be used to evaluate to. This is how
we think of lists as not just a data structure, but what to do with the
datastructure.

This new way of thinking is called a "fold". A fold is just a way to "evaluate"
a datastructure into a single value of some type.

Here's an example list constructed from the above Church encoded list:

  ```
  one 
    = cons 1 nill                   (from def. of List')
    = \b f -> f 1 ((\b f -> b) b f) (expanding to lambda form)
    = \b f -> f 1 b                 (simplifying inner redux)
  ```
Notice what `cons 1 nill` turns into: a function that calls `f` with `1` and
`b`. It's like this new form goes ahead and wires our logic of how to handle 
this list into the values of the list. Here's what I mean.

Let's say that you want
  ```
  ```



[^1]: For the curious this is done using pointers [1]. 
[^2]: This is extremely related to F-Algebras and encoding recursive types with
  them[2].

[1]: ./arrays-in-c.md
[2]: ./f-algebras-recursive-types.md
