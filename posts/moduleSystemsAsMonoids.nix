conix: with conix; [
  
"# " { title = "Module Systems As Monoids"; }''

As I've started working on Conix in the Nix programming language I ran
into the module systems problem.

# Re-Useable Code

Packages, modules, and the like all solves ''(r (builtins.length data.problems))'' 
meta-software problems:

''(list { problems = [
  "Grouping common functioning code and storing different groups in respective files."
  "Using code that is written outside the file where it's being used."
  "Organizing code into logical units that compose."
];})''

For example, Javascript + NodeJS allows one to write common code in files
called modules which are defined as: 

''(code "js" ''
//defined in ./peano.js

exports = {
  zero: (f,x) => x,
  succ: (f,x) => f(x),
  add:  (x,y) => (f,x) => x(f,y(f,x)),
}

'')''
This file is exporting an API defining Peano arthimetic. 

To consume some code in this API NodeJS syntax requires one to use the
`require` statement:

''(code "js" ''

const { zero, succ, add} = require(./peano.js);

//code here would use the zero, succ, and add functions

'')''

There are pros and cons to organizing code using explitely local file / module
references:

  * If the file structure of the project changes then `require` statements
  could break and thus give the programmer a clue as to which pieces of their
  code need to be updated.

  * Developers know exactly what code they are using. If while debugging they
  realize that one of the functions they are using is causing problems they
  know exactly which dependencies to investigate next.

There are cons however:

''(list [

  ''
  Explicit import statements disallow composability of APIs. That is,
  If I wanted to write a different implementation for the Peano API and 
  swap it out on the client code - say for testing purposes - I can't.
  ''

  ''
  Re-factoring this code out of this codebase becomes difficult. The more
  explicit imports the more code re-writes I have to do if I want to move the
  client code to its own project. Furthermore, if `peano.js` were to move to
  its own package then all of that file's dependencies will have to be
  modified.
  ''

])''

I would argue that these issues crop up in any language the requires some
explicit importing module system. Some of these issues can be defered by
making your code depend on general APIs instead of more specific ones, or
careful planning and architecting a code base before starting a project.
However, these approaches avoid the cons described above.

# Monoids As Modules.

## Intro To Monoids

I do not want to give a deep dive into monoids, however you'll need a basic
understanding of them to keep moving forward.

A monoid is made of 2 things.

''(list [
  ''
  A set of things. For example, the set of all paint colors (`Red`, `Blue`,
  ...).
  ''

  ''
  A binary operator. I'll use `<>` to represent this binary operator. For
  example, mixing 2 paint colors together (`Red <> Blue`) to produce a paint
  color (`Purple`).
  ''
])''

Further, a monoid must have the following properties.

''(list [

  ''
  The set of things must have an identity element such that when combined with
  any other element produce that same element. For example, let's say there is
  a color called `Transparent` such that: `Transparent <> Blue = Blue` and
  `Blue <> Transparent = Blue`.
  ''

  ''
  The binary operator is associative. That is: 
  `(Blue <> Red) <> White = Light Purple = Blue <> (Red <> White)`. This means
  that the order which we reduce combinations doesn't matter. Note, this
  isn't the same as saying `Blue <> Red = Red <> Blue`. This is called
  commutativity and the binary operator of a monoid isn't required to be 
  commutative.
  ''

])''

## What _Is_ A Module?

Let's stop and think, what is a module really? That is when we sit down and
find the common properties of module-like features across multiple languages
what do we find? 

First, a module is something that exports a collection of expressions in that
language where each expression is paired with a unique identifier. I'll call
these expressions + identifier pair a definition. Typically these collections
are manifested as features particular to that language: classes in OOP
languages, objects in untyped languages like JavaScript and Nix, and modules in
Haskell. Each of these collections should be able to be combined to create
larger collections. That is we can form larger modules from smaller ones.

Second, a module requires some way of depending on other modules. Again most
languages use explicit import statements. Here's a sample of some:

''(list [

  ''
  Javascript: `const { ... } = require(./some/file.js)`
  ''

  ''
  Haskell: `import qualified Data.ByteString as B`
  ''

  ''
  Nix: `let F = import ./foo.nix in ...`
  ''

  ''
  Elm-lang: `import List as L`
  ''

  ''
  Java: `import java.util.*;`
  ''

])''
In each of these examples we are solving 2 problems. Where is the target
dependency located? And, how do we bring it into scope? 

Modules should have the following properties:

* Combining modules avoids name clashes.  Let's say we have 2 modules `A` and
`B` - each containing a definition with identifier called `x`. If we combine
these modules `C = A <> B` then we would get a name clash - which module should
define `C`'s `x` definition? The answer is `C` should be defined in such a way
that we avoid the issue altogether.

* A module shouldn't not be allowed to depend on a non-existant module. Just
like calling a variable that doesn't exist is illegal - so is calling a module.

## Module Features

* Modules should be easy to extract from a project and turned into their own
projects.

* A module should be an independtly shippable unit. That is a module should
easily transported across different projects with ease.

* A module should be version controlled. Modules change over time and thus
it's not enough to state the name of a module to use but also what point in
time that module lives.

* A module should have meta-data and documentation attached to it. Things like
copy{right,left}, website, author, etc.

## Modelling a Module

To model this let's start by thinking about the most basic module: an empty
module. This module would contain no definitions 

# A Debugging Language Feature

So how do we solve the problem of figuring out where certain code comes from?

I propose we push this problem onto the compiler / language. Why not have a 
special syntax that asks the compiler to dump out where a particular variable's
definition originates from as a warning - or something similar? This way we can
avoid having to explicitely state where a function originates but still trace
issues up the module tree if we need to.

'']
