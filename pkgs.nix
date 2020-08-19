import <nixpkgs>
{ overlays = import (builtins.fetchGit
    { url = "https://github.com/theNerd247/conix.git";
      ref = "v0.1.0";
    });
}
