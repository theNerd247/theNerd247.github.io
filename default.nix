let
  conix = (import ./pkgs.nix).conix;
in
  { site = conix.run (x: with x;
    [ 
      (dir "resume" (import ./resume))
      (import ./index.nix)

      (importPostFile ./sermons/canIBeSureImSaved.nix)

      # (import ./contents/making-a-sandwich.nix)
      # (import ./contents/no-vars-js.nix)
      # (import ./contents/why-fp-eaql.nix)
      # (import ./contents/conix-intro.nix)
      # (import ./contents/practicalRecursionSchemes.nix)
      # (import ./runJs.nix)
      # (import ./withDrv.nix)
      # (import ./dotgraph.nix)
    ]);

    resume = conix.run (import ./resume);
  }
