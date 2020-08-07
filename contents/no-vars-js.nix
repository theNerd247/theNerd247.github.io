(import ../newPost.nix) 
  { name = "no-vars-js";
    tags = [ "draft" "javascript" "variables"];
    title = "JavaScript with No ...Variables?";
  }
(conix: [
"# "(conix.at [ "posts" "no-vars-js" "meta" "title" ])'' 

Let's have some fun. Take the following javascript code and re-write it such
that there are internally declared variables.

''((import ../runJs.nix) "buildHouse-imperative" true conix 
''
const modifyPair = pair => {
  const first = pair.first
  const second = pair.second

  const result = { first: first*second, second: first+second }

  return result;
}

console.log(modifyPair ({ first: 2, second: 3}))
'')

((import ../runJs.nix) "buildHouse-functional" true conix 
''
const first = pair => pair.first
const second = pair => pair.second

const mkPair = first => second => ({ first, second })

const both = f => g => pair => mkPair (f (pair)) (g (pair))

const mult = pair => first (pair) * second (pair)
const add = pair => first (pair) + second (pair)

const modifyPair = both (mult) (add)

console.log(modifyPair(mkPair (2) (3)))

'')
''

Take a look at: 
'' ((import ../codeBlock.nix) [ "posts" "no-vars-js" "buildHouse-functional" "code"] "javascript" 1 2 conix)''

Notice how we're creating a really thin wrapper around accessing a value from an object.

''

])
