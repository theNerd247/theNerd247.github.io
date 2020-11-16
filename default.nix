let
  run = (import ./pkgs.nix).conix.runExtended [ (import ./time.nix) (import ./postHtmlFile.nix) ];
in
  { site = run
    (x: with x; [ 
      (dir "resume" (import ./resume))

      (import ./index.nix)

      (dir "sermons" (nest "sermons" (importPostsDir "./sermons")))

      (dir "posts" (nest "posts" (importPostsDir "./posts")))

      (dir "notes" (nest "notes" (importPostsDir "./notes")))

    ]);

    resume = run (import ./resume);
  }
