conix: { posts.no-vars-js = with conix.lib; postHtmlFile "no-vars-js" "" (texts [
{ tags = [ "javascript" "variables"]; draft = true; }
"# "(label "title" "JavaScript with No ...Variables?")'' 

Let's have some fun. Take the following javascript code and re-write it such
that there are no `const` keywords used.

''(jsSnippet "buildHouse-imperative" ''

const modifyPair = pair => {
  const first = pair.first
  const second = pair.second

  const result = { first: first*second, second: first+second }

  return result;
}

console.log(modifyPair ({ first: 2, second: 3}))
'')

(jsSnippet "buildHouse-functional" ''
const first = pair => pair.first
const second = pair => pair.second

const mkPair = first => second => ({ first, second })

const both = f => g => pair => mkPair (f (pair)) (g (pair))

const mult = pair => first (pair) * second (pair)
const add = pair => first (pair) + second (pair)

const modifyPair = both (mult) (add)

console.log(modifyPair(mkPair (2) (3)))

'')''


Take a look at: 

```javascript
''(t (extractLines 1 2 conix.posts.no-vars-js.buildHouse-functional.code))''
```

Notice how we're creating a really thin wrapper around accessing a value from
an object.

''

]);}
