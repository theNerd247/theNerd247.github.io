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
    = cons 1 nill                   (from def. of ListC)
    = \b f -> f 1 ((\b f -> b) b f) (expanding to lambda form)
    = \b f -> f 1 b                 (simplifying inner redux)
  ```
Notice what `cons 1 nill` turns into: a function that calls `f` with `1` and
`b`. It's like this new form goes ahead and wires our logic of how to handle 
this list into the values of the list. Here's what I mean.

Let's say that you want to count the elements in a list. To solve this let's
just think about the return type. What type describes the result of counting a 
list? Of course! Natural numbers[^3]! So we need a function of type `ListC a b →
Nat`. What should we put for the `b` type? Well look at the definition of `ListC`. 
The `b` reprents the result of evaluating our list, in this case `Nat`. So our function
will be:

  ```
  countL :: ListC a Nat → Nat
  countL = ???
  ```
So how do we count this list? Well let's take each case in mind. What happens if the list is 
empty? Then we return `0`. But because our `ListC` doesn't have a constructor for the empty
list we can't just pattern match on the incoming list to see if it's empty. And it would be unwise
to have a separate function to check if the list is empty or not[^4]. Remember the definition of
our `ListC`. It is a function that takes in the result for when the list is empty, and a function
for what to do when the list is not empty. So all we need to do in order to handle the empty case
is to pass our default value to this function:

  ```
  countL :: ListC a Nat → Nat
  countL list = list 0 ??? 
  ```

And if it's not empty? Well by the definition of `ListC` someone who created the list we're evaluating 
would have already done the work of extracting the head and tail from the list. All we need to do is 
write a function of type `a → b → b` or in this case `a → Nat → Nat`. This function, which we define, 
tells the list function what to do with a single element of the list and the result after having evaluated
the rest of the list already. Here's that function:

  ```
  increaseSize :: a → Nat → Nat
  increaseSize a sizeOfTail = 1 + sizeOfTail
  ```
And to tie everything together we pass the `increaseSize` function as the
second argument of the list. Here's everything in one snapshot:

  ```
  countL :: ListC a Nat → Nat
  countL list = list 0 increaseSize 

  increaseSize :: a → Nat → Nat
  increaseSize a sizeOfTail = 1 + sizeOfTail
  ```

[^1]: For the curious this is done using pointers [1]. 
[^2]: This is extremely related to F-Algebras and encoding recursive types with
  them[2].
[^3]: No! Not `Int` or `Num`! Why? `Int` contains negatives. `Num` could be a
  decimal! We don't want bugs creeping into our code where we could have a list
  of length 0.5 or -2. Natural numbers are: 0, 1, 2, …
[^4]: This isn't Java or some other imperative language. If statements can
  typically be avoided in functional programming.

[1]: ./arrays-in-c.md
[2]: ./f-algebras-recursive-types.md
