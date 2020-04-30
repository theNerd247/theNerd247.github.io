{ pkgs ? import <nixpkgs> {}}:

with pkgs;

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
      pandoc-sidenote = import ./pandoc-sidenote.nix { inherit pkgs; };
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
