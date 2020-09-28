conix: { posts.conixEvaluator = with conix.lib; texts [
''
The Problem
==========
As a side note: I've been thinking about the infinite recursion issue as I've
had more time to play with it. 

A key requirement of conix is to make it convenient for users to write content
without a lot of overhead. The way this is currently done is by taking
advantage of Nix's heterogenous lists, multiline strings, and string
interpolation:

```nix
conix: conix.lib.merge
[ ''
This is some content ....

This is a use of a variable ${conix.foo}
'']
```
If we were to add types to the above expression `merge` would have type: `merge
:: [Either String m a] -> m a`. However, Nix is a monotyped language and thus
`merge` has type `merge :: [NixValue] -> NixValue`. So we need to manually
inspect values in the list and determine their runtime type in order to produce
a final AST value of type `m a`. We can do this via the builtin: `typeOf`. 

However, it is impossible to determine if a Nix value is either an conix AST
value (an attribute set with a `_type` attribute) without triggering infinite
recursion. This is because `typeOf` is strict in the Nix evaluator and so the
act of inspecting a value's type forces that value to be evaluated. And if a
value is constructed using an infinitely recursive value (i.e one that relies
on the input of a function that is passed to fix) then we end up triggering
finite recursion. 

A solution to this problem is to push the issue down to the user and force them
to notate when they are constructing a string that contains an interpolated
value. However this introduces some nasty syntax for example:

```nix
conix: conix.lib.merge
[''
This is a sample ''(conix.lib.text conix.foo)''
'']
```
Here `''(conix.lib.text conix.foo)''` is used instead of the nice
`${conix.foo}` sytnax.

Another Thought
=============

Right now I've limited myself to using `fix` as the core evaluator. At first
sight it made sense to do this, however, I'm wondering if abandoning it would
prove any interesting solutions. I hope I'm not forced to using `fix`. Firstly,
`conix` should be a turing incomplete language. It would be better if users
couldn't even express statements that ended in infinite recursion to begin
with. Note to self: this isn't the same as having the interpreter claim a
variable is not in scope. 

So, that said, I'm wondering if instead of using `fix` I write a 2 pass
interpreter. Here's the setup:

Users currently write statements of type `AttrSet -> AST` in order to make
accessing variables in the global scope convenient. Technically users are
constructing Conix AST values by hand so I'm giving them a weird blend of
writing expressions both in the target language (Conix) and the host language
(Nix).

Currently we are passing this function into the evaluator: `(AttrSet -> AST) ->
AttrSet`:

```nix
eval expr = fix (x: eval (expr x.data))
```

Here's the new solution: Keep the user's to writing `expr :: AttrSet -> AST`
expressions. This gives them the most convenience. In order to statically
analyze the AST result we instead pass in an empty environment `{}` to `expr`
and then

The first pass would statically analyze the AST for any `tell` statements and
collect the defined variables. Then the second pass would actually perform the
evaluation using the newly collected arguments.

''];}
