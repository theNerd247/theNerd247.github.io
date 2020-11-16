import <nixpkgs>
{ overlays = import (builtins.fetchGit
    { url = "https://github.com/theNerd247/conix.git";
      ref = "master";
      rev = "af94b448d64d918de165ba884f3ae6165ef8d0e8";
    });
}
