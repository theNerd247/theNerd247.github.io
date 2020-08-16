let 
  pkgs = import ./pkgs.nix;

  buildHtml = name: page: pkgs.conix.build.pandoc 
  "html" 
  "--css ./zettelkasten.css --css ./homepage.css" 
  name [ page ];

  resumeData = x: x.pagesModule (import ./resume/data.nix);

  posts = 
    pkgs.lib.attrsets.mapAttrsToList buildHtml
      (pkgs.conix.buildPages
        [ 
          (import ./contents/making-a-sandwich.nix)
          (import ./contents/no-vars-js.nix)
          (import ./contents/what-is-programming.nix)
          (import ./contents/why-fp-eaql.nix)
          (import ./contents/conix-intro.nix)
          (import ./contents/index.nix)
          resumeData
        ]
      ).posts;

  paths = posts ++ [ (import ./resume).site ] ++ [ ./static ];
in
  (import ./copyJoin.nix) pkgs "zettelkasten" paths
