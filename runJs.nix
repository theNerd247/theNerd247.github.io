conix: with conix; module (_: [])
{
  jsSnippet = expr 
  "Name -> JsCode -> Module" 
  ''
    Runs some javascript code and produces code blocks - one for the code
    and the other with the evaluated code (using nodeJs). The resulting
    module is nested under the given name.
  ''
  (name: x:
    code "javascript" (file 
      (codeText:
        let
          jsFile = pkgs.writeText "${name}.js" codeText;
          
          nodeStdOut = pkgs.runCommandLocal "${name}-stdout" { buildInputs = [ pkgs.nodejs ]; } ''
            ${pkgs.nodejs}/bin/node ${jsFile} | tee $out
          '';
        in
          builtins.seq nodeStdOut jsFile
      ) 
      x
    )
    ;
}
