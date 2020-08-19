conix: { lib = rec {
  docs.withDrv.docstr = ''
    Set the `drv` attribute in the given module by calling the given function
    with that module. This is provided purely as a convenience function for 
    single file pages.

    ```nix
    conix: { foo = with conix.lib; withDrv (markdownFile "foo") (texts [ 
    '''
    ... 
    '''
    ]);}
    ```

    This is equivalent to:

    ```nix
    conix:
    let 
      module = conix.lib.texts [...];
    in
      { foo = conix.lib.mergeModules module { drv = mkDrv module; } };
    ```
  '';
  docs.withDrv.type = "Name -> (Module -> Derivation) -> Module -> Module";
  withDrv = name: mkDrv: module: 
    conix.lib.mergeModules module { drv = mkDrv module; }
  }; 
}
