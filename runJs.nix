conix: with conix; module (_: [])
{
  jsSnippet = expr 
    "Name -> JsCode -> Module" 
    ''
    Create a JS code block while running the given JS code through the NodeJS evaluator
    to verify the code is correct.
    ''
    (name: x: c:
      [
        (code "javascript" ({ snippets.${name} = file
          (codeText:
            let
              jsFile = pkgs.writeText "${name}.js" codeText;
              
              nodeStdOut = pkgs.runCommandLocal "${name}-stdout" { buildInputs = [ pkgs.nodejs ]; } ''
                ${pkgs.nodejs}/bin/node ${jsFile} | tee $out
              '';
            in
              builtins.seq nodeStdOut jsFile
          )
          "${name}.js"
          x;
        }))
 
        #"[Download this snippet](" (r (link c.refs.snippets.${name}))")"
      ]
    )
    ;
}
