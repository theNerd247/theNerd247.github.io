with (import <nixpkgs> { config = import ./haskell.nix; }); 

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

  pandoc-tags = haskellPackages.pandoc-tags;

  tufte-pandoc = callPackage ./tufte-pandoc.nix 
    { inherit tufte-css;
      pandoc-sidenote = pkgs.haskellPackages.pandoc-sidenote;
      pandocExtra = builtins.concatStringsSep " "
        [	"--css=./static/extra.css"
        	"--filter=${pandoc-tags}/bin/pandoc-tags"
        	"--lua-filter=./pdlinks.lua"
        ];
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
