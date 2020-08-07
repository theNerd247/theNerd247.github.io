(import ../newPost.nix)
  { name = "making-a-sandwich"; 
    tags = [ "draft" "functional-programming" "philosophy" ];
    title = "What if I didn't Give you a Sandwich";
  } (conix: [
"# "(conix.at ["posts" "making-a-sandwich" "meta" "title"])
''
Here's a question:

> If I give you the recipe for making a sandwich and all of the recipe's
> requirements have I given you a sandwich?[^1]

If I said yes, the you'd call me absurd - and rightly so. Having knowledge
and materials doesn't imply that the job has been done.

But what if we lived in a world where this was true? That is, what if the
existence of instructions and materials implied the existence of results? Then
the answer to the above question would be yes! (And I would have gotten into
less trouble with my parent's as a kid).

Now in the real world things like time, human will, and God get prevent us from
being able to make such claims. But programming isn't the real world - it's the
world of the mind where most things are possible (so long as they are logically
consistent). Every programming language must answer yes to the above question.

## Modus Ponens

Our sandwich question can be formally stated in mathematics. Let 

  * Let `P` represent "the requirements"
  * Let `P -> Q` represent "the recipe exists" (and also to mean "If the requirements exist then the sandwich exists")
Modus Ponens says:

  ```
  (P -> Q) -> P -> Q
  ```
In English: If the statement "If P is true then Q is true" is true and "P is true" then "Q is true".

The Curry-Howard isomorphism

## P

''])
