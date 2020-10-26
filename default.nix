let
  conix = (import ./pkgs.nix).conix;
in
  { site = conix.run (x: with x;
    [ 
      (dir "resume" (import ./resume))
      (import ./index.nix)

      (importPostsDir "./sermons")
    ]);

    resume = conix.run (import ./resume);
  }
