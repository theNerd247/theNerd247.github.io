let
  config = {
    packageOverrides = pkgs:
    { haskellPackages = pkgs.haskellPackages.override
      { overrides = self: super:
          import ./pandoc-sidenote.nix self super;
      };
    };
  };

  pkgs = import <nixpkgs> { inherit config; }; 
in with pkgs;
let

  tufte-css = stdenv.mkDerivation
    { name = "tufte-css"; 
      src = builtins.fetchGit
      { url = "https://github.com/edwardtufte/tufte-css.git";
        ref = "gh-pages";
      };
      installPhase = ''
        mkdir -p $out
        cp -r et-book/ $out/et-book
        cp tufte.min.css $out/tufte.min.css
        '';
    };

  tufte-pandoc = callPackage ./tufte-pandoc.nix 
    { inherit tufte-css;
      pandoc-sidenote = pkgs.haskellPackages.pandoc-sidenote;
    };
in

stdenv.mkDerivation
{ name = "noah-zettelkasten";
  src = ./.;
  buildInputs = [ tufte-pandoc ];
  buildPhase = 
    ''
    ${tufte-pandoc}/bin/tufte-pandoc
    '';

  installPhase =
    ''
    mkdir -p $out
    cp ./html/*.html $out/
    cp -r ./static $out/static
    '';
}
