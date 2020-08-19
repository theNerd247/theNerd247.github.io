conix: { posts.making-a-sandwich = with conix.lib; withDrv (markdownFile "making-a-sandwich") (texts [
{ tags = [ "functional-programming" "philosophy" ]; draft = true;} 
"# "(label "title" "What if I didn't Give you a Sandwich")''

Here's a question:

> ''
(label "prem1" ''If I give you the recipe for making a sandwich'')
" and "
(label "prem2" ''all of its ingredients, cookware, etc.'') 
(label "conc" ''Can I assume that at somepoint in time a sandwich exists?'')
''


To be clear, I'm not asking if you are lazy or eager in your work ethics.  The
answer to this question depends on whether I can assume you know what to do
with both ingredients and recipe and that I will get back as having a
sandwich.

The answer to this question is at the heart of computer science, functional
programming, and mathematics.

## Modus Ponens

Let's restate the question in more formal terms. I'll use capital letters and
symbols to represent the logical statements about sandwiches above.

English | Symbols
--- | ---
"''(t conix.posts.making-a-sandwich.prem1)''" | `P -> Q`
"and"                                         | "&"
"''(t conix.posts.making-a-sandwich.prem2)''" | `P`
"''(t conix.posts.making-a-sandwich.conc)''"  | `Q`

To write the entire statement using only symbols looks like:

```
(P -> Q) & P -> Q
```
In mathematical logic this statement (called "modus ponens") is a true
statement. To rephrase it in general English: "If `(P -> Q)` exists and `P`
exists then that implies that `Q` exists". 

This gives us the answer to our original question: yes, the existence of
recipes and their matching ingredients implies that the sandwich exists if
modus ponens holds.

## Sandwiches as Arguments; Recipes as Programs

Programmers abstract their programs using functions. Large and complex
processes can be hidden away behind the walls of a function and whenever a
programmer desires to make use of that process they simply call that function.
And just like with recipes, functions produce a result.

1. Haskell:
  ```haskell
  apply :: ((a -> b), a) -> b
  apply (f, a) = f a
  ```
1. Typescript
  ```typescript
  function apply<A,B>(f, a) : B { return f (a); }
  ```
1. C++
  ```c++
  template<A,B> B apply(f Func<A,B>, a A) {
    return f(a);
  }
  ```

The statement `(P -> Q) & P -> Q` is a function called "apply" in programming.
It takes a function and an argument and applies the function to that argument.
Every programming language must have function application. Apply is so
fundamental to programming languages that its often the smallest operator. ` `
in Haskell (that's a space, mind you), and `( )` in Typescript and C++. 

'']);}
