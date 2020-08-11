let 
  pkgs = import ./pkgs.nix;

  buildHtml = name: page: pkgs.conix.build.pandoc "html" "--css ./zettelkasten.css" name [ page ];

  posts = 
    pkgs.lib.attrsets.mapAttrsToList buildHtml
      (pkgs.conix.buildPages
        [ 
          (import ./contents/making-a-sandwich.nix)
          (import ./contents/no-vars-js.nix)
          (import ./contents/phd-research.nix)
          (import ./contents/what-is-programming.nix)
          (import ./contents/why-fp-eaql.nix)
          (import ./contents/conix-intro.nix)
          (import ./contents/index.nix)
        ]
      ).posts;

  paths = posts ++ [ (import ./resume).site ] ++ [ ./static ];
in
  (import ./copyJoin.nix) pkgs "zettelkasten" paths
