import <nixpkgs>
{ overlays = import (builtins.fetchGit
    { url = "https://github.com/theNerd247/conix.git";
      ref = "v0.1.0-api";
      rev = "b60572b2ed4c6037aab48e00e8f50723bf00b1b7";
    });
}
