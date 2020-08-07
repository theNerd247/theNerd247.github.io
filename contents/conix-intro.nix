(import ../newPost.nix) 
{ name = "conix-intro";
  tags = ["draft" "conix"];
  title = "Comonadic Content in Nix";
}
(conix: ["# "(conix.at [ "posts" "conix-intro" "meta" "title"])
''
## We Need a Better Authoring Tool

## Readmes That Break

## Including Source Code - That Works!

## All The Functional Power

''
])
