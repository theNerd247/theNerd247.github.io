---
title: The FoldM Data Structure
tags:
  - Haskell
  - programming
  - Monads
---

Folds can be data types:

  ```
  type Fold a b x = (x → a → x) → x → (x → b) → b

  type FoldM (m :: Type → Type) a b x = (x → a → m x) → m x → (x → m b) → m b

  Fold ≡ FoldM Identity
  ```

Shell from the Haskell `turtle` library defines a FoldShell as:

  ```
  data FoldShell a b = ∀x. FoldShell (x → a → IO x) x (x → IO b)
  ```
  * The `x` type refers to the values that are passed between calls of the
    shell evaluator. 
  * `a` refers to the type of values that are unique to each call to the
    evaluator. 
  * `b` refers to the type of values that are returned from the shell[^2].

Notice the `∀x.` on the right hand side of the `=`. This existential
quantification is what allows users of this `FoldShell` type to specialize the
what the intermediate type is for that fold.

A `Shell`[^1] is then defined as:

  ```
  newtype Shell a = Shell {unShell :: ∀r. FoldShell a r → IO r}
  ```
Which is a natural transformation[3] from a `FoldShell` to an `IO`.

[^1]: A shell is just the mechanism in which Bash pipes are defined. It's the
  datastructure that allows one command to pipe values to another.
[^2]: Why do we need this? I don't know. Good question though. My guess is that
  it allows us to use a different type for the accumulator that's simplier and
  then convert that into the "real result" of the fold once we've finished. If 
  this is the case then I'd say you could remove it because it forces the author 
  of the fold to think more simply and only write the fold to do just enough for
  what it needs to do.


[1]: ./church-numerals.md 
[2]: ./lambda-calculus-abstractions.md
[3]: ./natural-transformation.md
