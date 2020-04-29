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
  buildInputs = [ neuron ];
  src = ./.;
  buildPhase = 
    ''
    ${neuron}/bin/neuron -d . rib -o ./docs
    '';

  installPhase =
    ''
    mkdir -p $out
    cp -r docs/* $out/
    '';
}
