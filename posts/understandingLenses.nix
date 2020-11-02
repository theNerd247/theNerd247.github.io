conix: { posts.understandingLenses = with conix.lib; texts [
{ draft = true; }

''# ''(label "title" "Understanding Lenses")''

# Indexing 

Accessing parts of a datastructure is at the hearts of programming. Indexing
a datastructure is this act. A value of some index type maps to values within
a datastructure. Most common is indexing a list:

  ```haskell
  indexList :: Natural -> [a] -> a
  ```
Here `Natural` is our index type and the retrieved value is `a`[^1]. How about
a tree? 

  ```haskell
  data Tree a = Tree a [Tree a]

  indexTree :: [Natural] -> Tree a -> a
  ```
Here the index is a `[Natural]` and the retrieved type is `a`. This list
describes the path into the tree to grab a specific value.

Lenses are the function form of indexes. Instead of representing the path to a
particular value into a datastructure with a value, we represent it with a
function. ''#TODO prove this statement
''

```haskell
indexList :: ([a] -> a)    -> [a]    -> a
indexTree :: (Tree a -> a) -> Tree a -> a

index :: (t a -> a) -> t a -> a
```

Functions that use indexes we'll call utilities. And instead of calling them 
indexes we'll call them lenses. Here are a few utilities:

```haskell
setList :: a -> [a] -> [a]
setTree :: a -> Tree a -> Tree a

modifyList :: (a -> a) -> [a] -> [a]
modifyTree :: (a -> a) -> Tree a -> Tree a

```


[^1]: I'm ignoring "proper" types for now to make a point. Of course `Maybe a`
or some other more restrictive type would be the appropriate industry-strength
type.

];}
