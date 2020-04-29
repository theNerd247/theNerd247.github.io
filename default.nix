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
    ${pandoc}/bin/pandoc\
        --resource-path=./static\
        -t html\
        -f markdown\
        --standalone\
        --table-of-contents\
        --output=./index.html\
        --file-scope\
        ./*.md
    '';

  installPhase =
    ''
    mkdir -p $out
    # cp -r docs/* $out/
    cp ./index.html $out/
    cp -r ./static $out/static
    '';
}
