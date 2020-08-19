(import ../newPost.nix) 
{ name = "conix-intro";
  tags = ["draft" "conix"];
  title = "Comonadic Content in Nix";
}
(conix: ["# "(conix.at [ "posts" "conix-intro" "meta" "title"])''

## We Need a Better Authoring Tool

  * content has implicit relationships that should be explicit.
  * why not just use a regular language with string contatenation?

```haskell
WriterF e a =
 = Censor ([e] -> [e]) a
 | Tell e a

datas :: WriterF e (Content a) -> Content a

censor :: ([e] -> [e]) -> a -> WriterF e a

onMerged :: (e -> e) -> a -> WriterF e a
onMerged f = censor (pure . f . fold)

labelData :: Path -> Content a -> Content a
labelData path = datas . onMerged (nest path)

ContentF a
 = Drvs  (WriterF Drv a)
 | Texts (WriterF Text a)
 | Datas (WriterF AttrSet a)
```
''
])
