import (
  builtins.fetchTarball 
  { url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-20.03.tar.gz";
  }
)
{ overlays = 
  [ (import ./haskell.nix)
    ( self: super:
      { pandoc-tags-shell = super.haskellPackages.pandoc-tags.env.overrideAttrs
        (old:
          { buildInputs = old.buildInputs ++
            [ self.ghcid
              self.cabal-install
            ];
          }
        );
      }
    )
  ]; 
}
