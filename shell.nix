with (import ./nixpkgs.nix);

let 
  ghc = haskellPackages.ghcWithPackages (h: with h;
    pandoc-tags.buildInputs
    ++ [ cabal-install pandoc ]
  );
in

mkShell
{ buildInputs = [ ghc haskellPackages.ghcid ];
}
