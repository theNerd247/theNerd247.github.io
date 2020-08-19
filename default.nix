let
  pkgs = import ./pkgs.nix;
in
  { site = pkgs.conix.buildPages (
      (import ./resume) ++ 
      [
        (import ./contents/making-a-sandwich.nix)
        (import ./contents/no-vars-js.nix)
        (import ./contents/what-is-programming.nix)
        (import ./contents/why-fp-eaql.nix)
        (import ./contents/conix-intro.nix)
        (import ./contents/index.nix)
      ]
    );

    resume = pkgs.conix.buildPages (import ./resume);
  }
