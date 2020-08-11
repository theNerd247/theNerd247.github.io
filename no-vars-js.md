# JavaScript with No ...Variables?
Let's have some fun. Take the following javascript code and re-write it such
that there are no `const` keywords used.

```javascript
const modifyPair = pair => {
  const first = pair.first
  const second = pair.second

  const result = { first: first*second, second: first+second }

  return result;
}

console.log(modifyPair ({ first: 2, second: 3}))

```

result: 
```
> { first: 6, second: 5 }

```


```javascript
const first = pair => pair.first
const second = pair => pair.second

const mkPair = first => second => ({ first, second })

const both = f => g => pair => mkPair (f (pair)) (g (pair))

const mult = pair => first (pair) * second (pair)
const add = pair => first (pair) + second (pair)

const modifyPair = both (mult) (add)

console.log(modifyPair(mkPair (2) (3)))


```

result: 
```
> { first: 6, second: 5 }

```



Take a look at: 
```javascript
const first = pair => pair.first
const second = pair => pair.second
```

Notice how we're creating a really thin wrapper around accessing a value from an object.

