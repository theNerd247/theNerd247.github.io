rec
{
  conix = (import ./pkgs.nix).conix; 

  run = conix.runExtended extensions;

  eval = conix.evalExtended extensions;

  extensions =
    [ 
      (import ./time.nix) 
      (import ./postHtmlFile.nix)
      (import ./runJs.nix)
    ];

  site = run s;

  s = 
  (x: with x; [ 
    (dir "resume" (import ./resume))

    (import ./index.nix)

    (dir "sermons" (nest "sermons" (importPostsDir "./sermons")))

    (dir "posts" (nest "posts" (importPostsDir "./posts")))

    (dir "notes" (nest "notes" (importPostsDir "./notes")))

  ]);

  resume = run (import ./resume);

  sop = run (import ./notes/gradSchoolPurposeStatement.nix);
}
