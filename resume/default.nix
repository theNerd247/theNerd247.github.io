let

  pkgs = import ../pkgs.nix;

  resume = import ./resume.nix;

  data = conix: conix.pagesModule (import ./data.nix);

  toplevel = conix: conix.mergeModules
    (data conix)
    (resume conix);
in
  { html = pkgs.conix.build.htmlFile "resume" toplevel;
    inherit resume;
    inherit data;
  }
