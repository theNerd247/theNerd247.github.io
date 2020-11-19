conix: with conix; [

''# ''{ title = "What is a Programming Language?"; }''

When I learned computer hardware architecture and programming I did so in a
bottom up manner.  I started with logic circuits to construct simple adding
machines, built on that to create the modern processor and then eventually
learned that programming was the act of bit-flipping to make the machine do
my bidding. I would say most people learn and think of programming in this way.

While I won't argue that when one writes a program they are commanding a
machine, I will argue that programming is not about the machine itself, nor
should we care about what's going on inside the machine. To this end we have to
forget that programming is about commanding a machine - directly through binary
or indirectly through a high-level language - and about accurately writing down
the solutions to some set of problems in such a way that a machine can then
remove manual labor from the picture. Languages that we use to express our
solutions are those that facilitate correct logical thinking, are logically
consistent, and can be translated into some machine's language[^1].

Checking the logical consistency and proving properties of a language is
difficult without using a mathematical model. This is where lambda calculus
comes in. We can model the basic features of any programming language using
lambda calculus and then use the statements written in lambda calculus to prove
different properties about our language.

# Motivating Exercise

A good way to discover the basic features of a language is to play a game. 
Here it is: 

Re-write the following JavaScript code using ONLY:

  * functions with any number of arguments
  * applying a function to values.
  * return statements
  * arithmetic statements


''(jsSnippet "jsExampleInit" { jsExampleInit = ''

const getSum = (xs) => {
  let sum = 0;

  for(let i = 0; i <= xs.length; i++) {
    sum = sum + xs[i];
  }
}

getSum([1, 2, 3]);

'';})''

And here's the solution in steps:

First we re-write the sum function using recursion to eliminate the `for`
statement.

''(code "js" ''

const getSum = (xs) => if xs.length === 0 then 0 else xs[1] + getSum(xs.slice(1));

getSum([1,2,3])

'')

#Next, we need to get rid of the array (notice how we didn't say that arrays
#were allowed in the above allowed expressions). To do this we need to 
#do 2 things: 
#  
#  * re-encode arrays using only functions in JS
#  * re-implement:
#
#    * getting the first element in an array using our new encoding
#    * extracting a list without its first element. 
#
#Here's the approach we'll take. First, we'll think of a list in terms of 
#how it will be used. That is instead of storing an actual list we'll 
#instead create a function that handles a list. 
#
#Second, let's assume a non-empty list is made of 2 things: 
#
#  1. the first element in the list (called the head) 
#  1. the rest of the list (called the tail). That is from the second element to
#  the last element in the list.
#
#A list-handler will need to 2 pieces of information to do its job.
#
#  1. what to do if the list is empty
#  1. Assuming the tail has already been evaluated, we need to know how to
#  combine an element in the list with the already-evaluated-tail.

''

Next we get rid of the array syntax and re-encode arrays using only
functions:

''(code "js" [''

''
# // this creates an empty list handler. It just 
# // returns what to do if a list is empty. Notice
# // because lists are the handlers we aren't concerned with
# // inspecting some list to determine if it's empty or not.
''
const nill = (valIfEmptyArray, onCons) => valIfEmptyArray;

''
# // this creates a new list handler from an element and a list
# // handler for the tail. What we do is first run the tail list handler,
# // and then run then onCons handler with the new head element and the 
# // evaluated list tail.
''
const cons = (newHead, listHandler) => (valIfEmptyArray, onCons) => onCons (listHandler(valIfEmptyArray, onCons), newHead);

const getSum = (listHandler) => listHandler(0, (sum, elem) => sum + elem);

getSum(cons(1, cons (2, cons(3, nill))));

''])''

Finally we'll rid ourselves of the toplevel `const` expressions.

''{ jsExampleFinal = code "js" ''

((nill, cons, getSum) =>
  getSum(cons(1, cons (2, cons(3, nill))))
)(
  (valIfEmptyArray, onCons) => valIfEmptyArray,
  (newHead, listHandler) => (valIfEmptyArray, onCons) => onCons (listHandler(valIfEmptyArray, onCons), newHead),
  (listHandler) => listHandler(0, (sum, elem) => sum + elem)
)

'';}''

Compare the final solution to the more traditional solution for summing
numbers:

_initial problem_

''(code "js" (r data.jsExampleInit))''

_solution_

''(r data.jsExampleFinal)''

Clearly the final solution is _not_ readable. So why on earth go through
this? The point of this exercise is 2 fold:

  1. To demonstrate that it's possible to restrict the programmer to the bare
  minimum tools for writing programs: functions, variables, and apply
  functions to expressions[^3] and still write meaningful programs.
  1. It's easier to study the properties of a language if we can restrict
  ourselves to the smallest features of a language. Things like objects,
  classes, interfaces, arrays, for loops, while loops, iterators, are all
  "sugar". They make writing programs easier but to a machine they get
  replaced with an extremely simple language.

# Lambda Calculus Basics

In algebra we write down algebraic expressions and then manipulate them to
solve problems. Similarly we write down lambda expressions and then manipulate
them to solve programming language problems.

Here are the core statements we can write in lambda calculus:

''(table ["\\<expression\\>" "Syntax" "Notes"]
  [["variable" "one of a-z" "These are the 'digits' of lambda calculus. They don't represent numbers - or anything else for that matter."]
   ["abstraction" "`\<variable> . <expression>`" "[^2]An abstraction is like a single variable function. It binds a variable to the expression."]
   ["application" "`<expression> <expression>`" "Application expressions are formed by placing two expressions adjacent to each other. As we will see they express the same thought of applying a function to a value. In algebra we write `f(x)` to apply `f` to `x`. In lambda calculus we write: `f x` (we don't use parenthesis)."]
   ["parenthesis" "`(<expression>)`" "Any expression wrapped in parenthesis are valid expressions"]
  ]
)''

## Examples

* Variables: `x`, `y` ...
* `\x . x`
* `\x . \y . x` - This expression is made of 2 nested abstractions. You could
  read it as: `\x . A` where `A = \y. x`.
* `(\x . x) y` - This is an application of `\x . x` to `y`.
* `(\x . \y . x) (\z . z)` - This is the application of `\x . y . x` to `\z . z`.
  Don't worry about figuring out what this means just yet.

Notice how `\x . \y . <expression>`  is like a multi-variable binding. Both `x` and `y`
are bound to `<expression>`. As a shorthand We can write `\x . \y .
<expression>` as `\x y . <expression>` instead.

# Reducing Lambda Expressions

Some lambda expressions can be reduced to smaller ones. Formally this is
called `beta` reduction however we aren't going to get into the formal side
of things. Here's the basics:

''(table ["\\<expression\\>" "Reduces To" "Notes"]
  [["`x`, `y`, ..." "`x`, `y`, ..." "Variables are as simple as they get, they do not reduce any further"]
   ["`\\x . <expression>`" "`\\x . <reduced-expression>`" "Abstractions can have their bodies reduced"]
   ["`(\\x . A) B`" "`A | x -> B`" "If an abstraction is applied to an expression then this reduces to the body of the abstraction (`A`) with each occurence of the bound variable `x` replaced with the applied expression `B`."]
   ["`<expression> <expression>`" "`<reduced-expression> <reduced-expression>`" "Applications reduce their individual expressions"]
  ]
)''

## Examples

Here are a few examples of reductions

  * `x ==> x` - Variables don't reduce
  * `(\x . x) y ==[x | x -> y]==> y` - This is like `const id = (x) => x; id(y)` in JS.
  * `\x . (\z . z) y ==[\x . (z | z -> y)]==> \x . y` - The body of an expression can be reduced.
  * `(\x y . x y) (\z . z) ==[x y | x -> (\z . z)]==> (\z . z) y ==[z | z -> y]==> z`


[^1]: "Machine's language" here doesn't refer only to binary used by
computers but to the more general notion of a simple language used by
an automatic machine.

[^2]: Note, I can't write an actual greek lambda character - so I am left to
using the ASCII look-alike: `\`. Normally we write a lambda instead of a
backslash.

[^3]: I've allowed arithmetic expressions because without them the above
solution would be confusing without first understanding lambda calculus. We
could very well remove the arithmetic expressions to arrive at only
functions, variables, and application of functions to expressions.


'']
