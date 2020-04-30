let
  src = builtins.fetchGit 
    { url = "https://github.com/jez/pandoc-sidenote";
      ref = "master";
    };
in

self: super:
  { pandoc-sidenote = self.callCabal2nix "pandoc-sidenote" src {};
  }
