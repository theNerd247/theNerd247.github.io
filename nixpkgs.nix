import (
  builtins.fetchTarball 
  { url = "https://github.com/NixOS/nixpkgs-channels/archive/nixpkgs-unstable.tar.gz";
  }
) { config = import ./haskell.nix; }
