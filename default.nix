let
  conix = (import ./pkgs.nix).conix;
in
  { site = conix.runExtended 
    [ (import ./time.nix) (import ./postHtmlFile.nix) ]
    (x: with x; [ 
      (dir "resume" (import ./resume))

      (import ./index.nix)

      (dir "sermons" (nest "sermons" (importPostsDir "./sermons")))

      (dir "posts" (nest "posts" (importPostsDir "./posts")))

      #(dir "notes" (nest "notes" (importPostsDir "./notes")))

    ]);

    resume = conix.run (import ./resume);
  }
