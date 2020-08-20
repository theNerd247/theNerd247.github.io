conix: { 
  docs.jsSnippet.docstr = ''
    Runs some javascript code and produces code blocks - one for the code
    and the other with the evaluated code (using nodeJs). The resulting
    module is nested under the given name.
  '';
  docs.jsSnippet.type = "Name -> JsCode -> Module";
  lib.jsSnippet = name: code:
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
