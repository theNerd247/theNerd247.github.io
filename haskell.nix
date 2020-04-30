{
  packageOverrides = pkgs:
  { haskellPackages = pkgs.haskellPackages.override
    { overrides = self: super:
        (import ./pandoc-sidenote.nix self super)
        // (import ./pandoc-tags self super);
    };
  };
}
