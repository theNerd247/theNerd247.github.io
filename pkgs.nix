import <nixpkgs>
{ overlays = import (builtins.fetchGit
    { url = "https://github.com/theNerd247/conix.git";
      ref = "master";
      rev = "323075a852742c5078157e0f99818674abce09d5";
    })
    { extensions = 
        [ (import ./time.nix)
          (import ./postHtmlFile.nix)
        ];
    };
}
