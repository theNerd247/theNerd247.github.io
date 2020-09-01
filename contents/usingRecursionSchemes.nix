conix: { notes.recursionSchemes.using = with conix.lib; texts [
''
# ''(label "title" "Using Recursion Schemes")''


Catamorphisms
=============

* used for consuming a fixed point of a functor
* terminates only if there exists at least one (`forall x. x -> F a`) terminal
  value.
* each recursive step can only contain information from the previous step.
* new fixed point construction

Anamorphisms
============

`recursion-schemes`
===================

  * Uses more generic implementation

  `Base t a`
  : the non-recursive functor that encodes some recursive type `t`. `a` refers
  to the data stored at the recursion holes.

  recusion-hole
  : a type hole in the recursion data structure that `Fix` fills in. 
  : e.g.  `ListF e a = Nill | Cons e a`. `a` here is the type hole. It may
    store the result of a previous recursion step (in use with algebras); or 
    the seed for the rest of the list (in use with co-algebras); or it may be a
    fixed point list wich is just the tail of the list.
''
];}
