let 
  pkgs = import <nixpkgs> { 
    overlays = import (builtins.fetchGit
      { url = "https://github.com/theNerd247/conix.git";
      });
    };

  buildHtml = path: 
    pkgs.conix.build.pandoc "html" 
      (builtins.replaceStrings [".nix"] [""] (baseNameOf path))
      [(pkgs.conix.runModule (import path))];
in
  pkgs.symlinkJoin 
    { name = "html";
      paths = builtins.map buildHtml
        [
          ./contents/home.nix
        ];
    }
