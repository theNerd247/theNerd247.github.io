name: inclueStdOut: conix: jsCode:
let
  pkgs = import ./pkgs.nix;

  nodejs = pkgs.nodejs;

  code = pkgs.writeText "${name}.js" jsCode;

# ${nodejs}/bin/nodejs ${code} | tee $out
  drv = pkgs.runCommandLocal "${name}-stdout" { buildInputs = [ nodejs ]; } ''
    ${nodejs}/bin/node ${code} | tee $out
  '';
in
conix.texts [ name ] [

(conix.hidden (conix.setVal [ "code" ] jsCode))

''```javascript
${jsCode}
```

${if inclueStdOut 
  then 
    ''
    result: 
    ```
    > ${builtins.readFile drv}
    ```
    ''
  else
    builtins.seq drv ""
}

'']
