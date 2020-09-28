conix: { lib.dotDigraph = with conix.lib; name: dotCode:
  let
    imgType = "svg";
    imgFile = "${name}.${imgType}";
   
    graphvizCode = conix.pkgs.writeText "${name}.dot" dotCode;

    diagraph = conix.pkgs.runCommandLocal
      "${imgFile}" 
      { buildInputs = [ conix.pkgs.graphviz ]; }
      "dot -T${imgType} -o $out ${graphvizCode}";
  in
    { drv = imgFile; text = "\n![](./${imgFile})\n"; }
}
