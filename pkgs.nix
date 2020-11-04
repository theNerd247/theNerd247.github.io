import <nixpkgs>
{ overlays = import (builtins.fetchGit
    { url = "https://github.com/theNerd247/conix.git";
      ref = "master";
      rev = "b5e44dd5c9f8df80c80105d2f276698fea287d89";
    })
    { extensions = 
        [ (import ./time.nix)
          (import ./postHtmlFile.nix)
        ];
    };
}
