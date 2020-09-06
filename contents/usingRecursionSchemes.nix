conix: { notes.recursionSchemes.using = with conix.lib; texts [
''
# ''(label "title" "Using Recursion Schemes")''

General Principles
==================

  1. the functor describes the recusion shape - not necessarily that 
     datastructure shape. Often the datastructure being processed provides the 
     shape of the recursion, however this is often _not_ the case.
  1. The functor determines whether termination will occur. A terminal value 
      must exist; i.e you can construct (`forall x. x -> F a`).

Catamorphisms
=============

* used for consuming a fixed point of a functor
* terminates only if there exists at least one (`forall x. x -> F a`) terminal
  value.
* each recursive step can only contain information from the previous step.
* new fixed point construction
* They seem to be less efficient since they are executed bottom up, however, 
  top-down recursion could potentially be infinite (as in the case of
  anamorphisms). 

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

Hylomorphisms
=============

  * Anytime you have some construction and deconstruction then you might be
    using a hylomorphism.

List construction using both ana and cata where a list is used as an input
==========================================================================

  * Can be viewed as:

This sounds like the job of a hylomorphism. But first, let's look at an
example:

''# TODO: might be worth while writing this as a full literate haskell program?
''
```haskell

-- Algebra version
-- In this case the functor is deconstructing the input list and we are
-- manually constructing the new list. This means we have full control over the 
-- output list construction at each step. However we give up controlling
-- the deconstruction of the input.
insertIf :: (a -> Maybe a) -> ListF [a] -> [a]
insertIf _ Nill = []
insertIf mkNewElem (Cons curElem newList) =
    maybe 
      (curElem : newList) 
      -- Note we could swap the order in which the new element is inserted here
      -- this indicates that the order of the new elements in the output list
      -- is independent of the shape of the recursion.
      (\newElem -> curElem : newElem : newList)  
      (mkNewElem curElem)

-- cata (insertIf pred) :: [a] -> [a]

-- CoAlgebra version
-- In this case the functor is constructing the output list and we are manually
-- deconstructing the input list. This means we have full power over how we 
-- deconstruct the input list. However we give up controlling the construction
-- of the outputlist
insertIf' :: (a -> Maybe a) -> [a] -> ListF [a]
insertIf' _ [] = Nill
insertIf' mkNewElem (curElem:tail) = 
  maybe 
    (Cons curElem tail) 
    -- Note if we were to swap `curElem` and `newElem` we'd end up recursing
    -- infinitely. This means we do not have the freedom to change the order in
    -- which curElem and newElem appear in the output. Because newElem is part
    -- of the new list seed the predicate function can inspect the previously
    -- inserted value and use that information for producing the next value.
    (\newElem -> Cons curElem (newElem : tail)) 
    (mkNewElem curElem)

-- ana (insertIf' pred) :: [a] -> [a]

```

Questions
=========

  * If a functor F a = Fix (G a) then what is 
    `alg :: F a -> a`? `alg :: Fix (G a) -> a` `alg == cata alg' | alg' :: G a b -> a`?

    cata a = c where c = a . fmap c . unfix
           = d where d = (cata a') . fmap c . unfix
           = e where e = (f where f = a' . fmap f . unfix) . fmap e . unfix
''
];}
