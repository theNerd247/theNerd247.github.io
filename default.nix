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
        [ (import ./contents/why-fp-eaql.nix)
          ((import ./resume).data)
          resume
          (import ./contents/index.nix)
        ]
      ).posts;
in
  (import ./copyJoin.nix) pkgs "zettelkasten" paths
