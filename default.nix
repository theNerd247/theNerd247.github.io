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

if lib.inNixShell then

mkShell 
{ buildInputs = [ neuron ];
}

else

stdenv.mkDerivation
{ name = "noah-zettelkasten";
  buildInputs = [ neuron ];
  src = ./.;
  buildPhase = 
    ''
    mkdir -p site
    neuron -d . rib -o site
    '';

  installPhase =
    ''
    mkdir -p $out
    cp -r site/* $out/
    '';
}
