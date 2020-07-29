---
title: Freer Monads
tags:
  - free-monads
  - haskell
  - programming
---

(_Note: this is a summary of[1]_)

Traditional state Monad looks like this:

```{.haskell}
data State s a = State { runState :: s -> (a, s) }
  
instance Functor (State s) where
  ...

instance Applicative (State s) where
  ...

instance Monad (State s) where
  ...

put :: s -> State s ()
get :: State s s
```

However we can use the free pattern to rewrite `State` as a pure language:

```{.haskell}
{-# LANGUAGE GADTs #-}

data FFree g a where
  FPure   :: a -> FFree g a
  FImpure :: g x -> (x -> FFree g a) -> FFree g a

instance Functor (FFree g) where
  fmap f (FPure x)     = FPure (f x)
  fmap f (FImpure u q) = FImpure u (fmap f . q)

instance Applicative (FFree g) where
  pure = FPure
  FPure f     <*> x = fmap f x
  FImpure u q <*> x = FImpure u ((<*> x) . q)

instance Monad (FFree g) where
  return = FPure
  FPure x      >>= k = k x
  FImpure u k' >>= k = FImpure u (k' >>> k)

(>>>) :: Monad m => (a -> m b) -> (b -> m c) -> (a -> m c)
f >>> g = (>>= g) . f

etaF :: g a -> FFree g a
etaF fa = FImpure fa FPure

data StateF s a where
  Get :: StateF s s
  Put :: s -> StateF s ()

type State s = FFree (StateF s)

runState :: s -> State s a -> (a, s)
runState s (FPure a)            = (a, s)
runState s (FImpure Get f)      = runState s  $ f s
runState _ (FImpure (Put s') f) = runState s' $ f ()

```
Notice what's going on here: `State` is no longer its own construct that
manually works out the details of Functor, Applicative, Monad, etc. Instead we
create a concrete way of describing what stateful operations mean - a GADT with
constructors representing the actions to take. The meaning of `State` is then
reified by the interpreter `runState`.

Checkout: [2], [3], [4]

[1]: http://okmij.org/ftp/Computation/free-monad.html
[2]: ./free-higher-order-monads.md
[3]: ./yoneda-lemma.md
[4]: https://reasonablypolymorphic.com/blog/freer-higher-order-effects/
