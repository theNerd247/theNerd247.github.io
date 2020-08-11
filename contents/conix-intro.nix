(import ../newPost.nix) 
{ name = "conix-intro";
  tags = ["draft" "conix"];
  title = "Comonadic Content in Nix";
}
(conix: ["# "(conix.at [ "posts" "conix-intro" "meta" "title"])''

## We Need a Better Authoring Tool

  * content has implicit relationships that should be explicit.
  * why not just use a regular language with string contatenation?

## Readmes That Break

## Scrap Your Cache - We Have Nix Store

## All The Functional Power

## My Blog Setup

## Including Source Code - That Works!


''
])
