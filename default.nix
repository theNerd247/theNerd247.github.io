with (import ./nixpkgs.nix);

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

  tufte-pandoc-srcs = stdenv.mkDerivation
    { name = "tufte-pandoc-srcs"; 
      buildInputs = [ tufte-css ];

      src = builtins.fetchGit
        { url = "https://github.com/jez/tufte-pandoc-css.git";
          ref = "master";
        };

      buildPhase = "";
      installPhase = ''
        mkdir -p $out
        cp ./tufte.html5 $out/tufte.html5
        cp ./*.css $out/
      '';
    };
 

  pandoc-tags = haskellPackages.pandoc-tags;

  tufte-pandoc = callPackage ./tufte-pandoc.nix 
    { inherit tufte-css;
      inherit tufte-pandoc-srcs;
      pandoc-sidenote = pkgs.haskellPackages.pandoc-sidenote;
      pandocExtra = builtins.concatStringsSep " "
        [	"--css=./static/extra.css"
        	"--filter=${pandoc-tags}/bin/pandoc-tags"
        ];
    };
in

stdenv.mkDerivation
{ name = "noah-zettelkasten";
  src = ./.;
  buildInputs = [ tufte-pandoc ];
  buildPhase = 
    ''
    rm -f md/index.md
    for f in md/*.md; do 
      name=$(echo $f | sed -e 's/.md\|md\///g')
      link="$name".html
      echo "* [$name]($link)" >> md/index.md
    done
    ${tufte-pandoc}/bin/tufte-pandoc
    '';

  installPhase =
    ''
    mkdir -p $out
    cp ./html/*.html $out/
    cp -r ./static $out/static
    cp -r ${tufte-css}/* $out/
    cp ${tufte-pandoc-srcs}/*.css $out/
    '';
}
