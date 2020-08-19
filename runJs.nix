conix: { lib.jsSnippet = name: code:
let
  nodejs = conix.pkgs.nodejs;

  codeFile = conix.pkgs.writeText "${name}.js" code;

  outFile = conix.pkgs.runCommandLocal "${name}-stdout" { buildInputs = [ nodejs ]; } ''
    ${nodejs}/bin/node ${codeFile} | tee $out
  '';
in
  conix.lib.set name 
    (conix.lib.snippet "javascript" code "> ${builtins.readFile outFile}");
}
