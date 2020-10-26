let
  conix = (import ./pkgs.nix).conix;
in
  { site = conix.run
    [ 
      (import ./resume)
      (import ./contents/making-a-sandwich.nix)
      (import ./contents/no-vars-js.nix)
      (import ./contents/why-fp-eaql.nix)
      (import ./contents/conix-intro.nix)
      (import ./contents/index.nix)
      (import ./contents/practicalRecursionSchemes.nix)
      (import ./runJs.nix)
      (import ./withDrv.nix)
      (import ./postList.nix)
      (import ./postHtmlFile.nix)
      (import ./dotgraph.nix)
      (import ./textsd.nix)
    ];

    resume = conix.run (import ./resume);
  }
