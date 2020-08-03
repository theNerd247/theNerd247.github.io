let

  pkgs = import ../pkgs.nix;

  toplevel = conix: conix.mergeModules
    (conix.pagesModule (import ./data.nix))
    ((import ./resume.nix) conix);
in
  pkgs.conix.build.htmlFile "resume" toplevel
