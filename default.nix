let 
  pkgs = import ./pkgs.nix;

  buildHtml = name: page: pkgs.conix.build.pandoc "html" "" name [ page ];

  resume =
    (import ./newPost.nix) 
      { name = "resume";
        tags = [ "resume" ];
        title = "Resume";
      } 
      (c: [((import ./resume).resume c)]);

  paths = 
    pkgs.lib.attrsets.mapAttrsToList buildHtml
      (pkgs.conix.buildPages
        [ 
          (import ./contents/making-a-sandwich.nix)
          (import ./contents/no-vars-js.nix)
          (import ./contents/phd-research.nix)
          (import ./contents/what-is-programming.nix)
          (import ./contents/why-fp-eaql.nix)
          (import ./contents/index.nix)
          ((import ./resume).data)
          resume
        ]
      ).posts;
in
  (import ./copyJoin.nix) pkgs "zettelkasten" paths
