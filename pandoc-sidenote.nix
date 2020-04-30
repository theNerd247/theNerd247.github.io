{ pkgs ? import <nixpkgs> {}}:

pkgs.haskellPackages.override 
{ overrides = self: super:
  { pandoc-sidenote = self.callCabal2nix "pandoc-sidenote" (
      builtins.fetchGit 
        { url = "https://github.com/jez/pandoc-sidenote";
          rev = "master";
        }
    );
  };
}
