conix: { lib.dotDigraph = with conix.lib; name: dotCode:
  let
    imgType = "svg";
    imgFile = "${name}.${imgType}";
   
    graphvizCode = conix.pkgs.writeText "${name}.dot" dotCode;

    digraph = conix.pkgs.runCommandLocal
      "${imgFile}" 
      { buildInputs = [ conix.pkgs.graphviz ]; }
      "dot -T${imgType} -o $out ${graphvizCode}";
  in
    { drvs = [digraph]; text = "\n![](./${imgFile})\n"; };
}
