import <nixpkgs>
{ overlays = import (builtins.fetchGit
    { url = "https://github.com/theNerd247/conix.git";
      ref = "v0.1.0-api";
      rev = "579fda9778358c83854c21ab7c2725f325a896b5";
    });
}
