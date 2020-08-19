conix: { lib.jsSnippet = name: code:
let
  nodejs = pkgs.nodejs;

  codeFile = conix.pkgs.writeText "${name}.js" jsCode;

  outFile = pkgs.runCommandLocal "${name}-stdout" { buildInputs = [ nodejs ]; } ''
    ${nodejs}/bin/node ${codeFile} | tee $out
  '';
in
  conix.lib.snippet "javacsript" name code
  ''
  > ${builtins.readFile outFile}
  ''
;}
