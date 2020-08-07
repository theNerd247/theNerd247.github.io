let 
  pkgs = import ./pkgs.nix;

  buildHtml = name: page: pkgs.conix.build.pandoc "html" "" name [ page ];

  resumeLink = conix:
    conix.text [ "resume" ] "[Resume](./resume.html)";

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
          resumeLink
        ]
      ).posts;

  paths = posts ++ [ (import ./resume).site ];
in
  (import ./copyJoin.nix) pkgs "zettelkasten" paths
