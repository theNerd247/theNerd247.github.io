let

  pkgs = import ../pkgs.nix;

  resume = import ./resume.nix;

  data = conix: conix.pagesModule (import ./data.nix);

  toplevel = conix: conix.mergeModules
    (data conix)
    (resume conix);

  html = pkgs.conix.build.pandoc "html" "--css ./latex.css --css ./main.css" "resume" [ (pkgs.conix.runModule toplevel)];

in
  { site = (import ../copyJoin.nix) pkgs "resume" [ html ./static ];
    resume = toplevel;
  }
