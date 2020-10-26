import <nixpkgs>
{ overlays = import (builtins.fetchGit
    { url = "https://github.com/theNerd247/conix.git";
      ref = "master";
      rev = "e351b84204b6ac2bc91b35022740b73ac1cb8a54";
    })
    { extensions = 
        [ (import ./time.nix)
        ];
    };
}
