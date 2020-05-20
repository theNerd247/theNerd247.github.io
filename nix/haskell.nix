self: super:

{ haskellPackages = super.haskellPackages.override 
  (old:
    { overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      ( hself: hsuper:
        { pandoc-tags = hself.callCabal2nix "pandoc-tags" ../pandoc-tags {};
        }
      );
    }
  );
}
