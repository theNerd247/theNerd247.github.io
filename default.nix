{ pkgs ? import <nixpkgs> {}}:

with pkgs;

let
  neuronGit = builtins.fetchGit 
  { url = "https://github.com/srid/neuron"; 
    ref = "master"; 
  };

  neuron = import neuronGit.outPath 
  { inherit pkgs;
    gitRev = neuronGit.shortRev; 
  };
in

stdenv.mkDerivation
{ name = "noah-zettelkasten";
  buildInputs = [ pandoc ];
  src = ./.;
  buildPhase = 
    ''
    # ${neuron}/bin/neuron -d . rib -o ./docs
    mkdir -p html
    echo "<ul>" > ./html/index.html
    for f in ./*.md; do
      name="$(basename -s.md $f).html"
      ${pandoc}/bin/pandoc\
          --resource-path=./static\
          -t html\
          -f markdown\
          --standalone\
          --output="./html/$name"\
          --lua-filter=./pdlinks.lua\
          --css=./tufte.css\
          --section-divs\
          $f
      echo "<li><a href='$name'>$name</a></li>" >> ./html/index.html
    done
    echo "</ul>" >> ./html/index.html
    '';

  installPhase =
    ''
    mkdir -p $out
    cp ./html/*.html $out/
    cp -r ./static $out/static
    cp ./tufte.css $out/tufte.css
    cp -r ./et-book/ $out/et-book
    '';
}
