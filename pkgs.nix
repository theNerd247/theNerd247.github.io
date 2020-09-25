import <nixpkgs>
{ overlays = import (builtins.fetchGit
    { url = "https://github.com/theNerd247/conix.git";
      ref = "master";
      rev = "cc78b71955977e106cee3b55173eb11ac62c5937";
    });
}
