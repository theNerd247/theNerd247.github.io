let 
  pkgs = import <nixpkgs> { 
    overlays = import (builtins.fetchGit
      { url = "https://github.com/theNerd247/conix.git";
      });
    };

  modules = [
    (import ./contents/home.nix)
  ];

  toplevelPage = pkgs.conix.buildPages modules;
in
  pkgs.conix.build.pandoc "html" "index" [ toplevelPage ]
