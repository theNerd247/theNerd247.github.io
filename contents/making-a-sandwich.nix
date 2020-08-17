(import ../newPost.nix)
  { name = "making-a-sandwich"; 
    tags = [ "draft" "functional-programming" "philosophy" ];
    title = "What if I didn't Give you a Sandwich";
  } (conix: [
"# "(conix.at ["posts" "making-a-sandwich" "meta" "title"])''

Here's a question:

> ''
(conix.text ["prem1"] ''If I give you the recipe for making a sandwich'')
" and "
(conix.text ["prem2"] ''all of its ingredients, cookware, etc.'') 
(conix.text ["conc"] ''Can I assume that at somepoint in time a sandwich exists?'')
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
"''(conix.textOf [ "posts" "making-a-sandwich" "prem1" ])''" | `P -> Q`
"and"                                                        | "&"
"''(conix.textOf [ "posts" "making-a-sandwich" "prem2" ])''" | `P`
"''(conix.textOf [ "posts" "making-a-sandwich" "conc"  ])''" | `Q`

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

## So What? 

Programmers abstract their programs using functions. Large and complex
processes can be summarized with a single word. In short, functions are
recipes and their arguments are ingredients. Let's restate the above in
terms of a function in a few languages. 

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

The statement `(P -> Q) & P -> Q` is a function called apply. The Haskell
version's type looks very similar to the math form. If you happen to know all
three languages you'll notice something: they are all just calling a function
with the given arguments. 

In fact, there's something called the Curry-Howard isomorphism that says that
calling a function is the same thing as pair a function with its arguments.

''])
