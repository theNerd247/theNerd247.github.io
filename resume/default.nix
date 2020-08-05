let

  pkgs = import ../pkgs.nix;

  resume = import ./resume.nix;

  data = conix: conix.pagesModule (import ./data.nix);

  toplevel = conix: conix.mergeModules
    (data conix)
    (resume conix);

  html = pkgs.conix.build.pandoc "html" "--css ./latex.css --css ./main.css" "resume" [ (pkgs.conix.runModule toplevel)];

  css = [ ./main.css ./latex.css ];
in
  { site = (import ../copyJoin.nix) pkgs "resume" ([ html ] ++ css);
    inherit resume;
    inherit data;
  }
