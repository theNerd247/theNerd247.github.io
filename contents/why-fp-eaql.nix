conix: { posts.why-fp-eaql = with conix.lib; withDrv (markdownFile "why-fp-eaql") (texts [
{ tags = [ "functional-programming" "eaql"]; draft = true; }
"# "(label "title" "Benefits of Functional Programming With EAQL")''


A DSL is a very specific language that aims to make encoding solutions to a
certain problem domain more intuitive. 

A person programs when they take any solution and "write it down". For
example a cook programs a cake by writing the recipe down. Recipes are
programs and executing a recipe is the making of the cake.

If encoding made is easy then creating solutions becomes easier. Not because
the problem is any easier to solve; but trying out new solutions takes
little brain power and time.

EAQL is a domain specific language for threat research and analysis. It was
designed to allow network security analysts to "write down their thoughts"
and automate executing them. For example:

```
'' # TODO: create a very simple EAQL code that's intuitive and not as FP-y
''
```


Functional programming provides a universal backbone - a machine that generates
other langauges - for encoding human logic into a computer.  It makes it easy
to combine create solutions and combine them in an easy way.

''

# Ideas 
# * A DSL makes you follow the rules of the problem at all times.
# * A DSL only allows you to express what the features provides; Lambda
#   calculus allows you to express _anything_. 
# * FP is Very easy to learn
#
# What I've learned at AWAKE
#
# * Communication driven development.
# * Get help early - even if you're "smart"
# * Creative solutions require a lot of problem context
# * Tutorial first development
# * Category Theory as a framework for reasoning about problems and writing the
#   best API.
# * Timing of new features
# 
# * How a progrogramming language really works
# * The interpreter pattern
# * A Language is an algebra; 1 Language = 1 Solution; combine languages to
#   combine solutions; Higher order languages to lift Human logic into the
#   solution.
# * Polysemy
# * F-Algebras and recursion schemes
# * Co-algebras
# * Lenses
# * Adjunctions
# * Lambda Cube
# * Hindly Milner type system
# * Writing an evaluator using recursion schemes
]);}
