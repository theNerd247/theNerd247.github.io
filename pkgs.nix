import <nixpkgs>
{ overlays = import /home/noah/src/com/conix
    # (builtins.fetchGit
    #{ url = "https://github.com/theNerd247/conix.git";
    #  ref = "master";
    #  rev = "b95c0325cb2b15fe64d485636a298c514f9013f3";
    #})
    { extensions = 
        [ (import ./time.nix)
          (import ./postHtmlFile.nix)
        ];
    };
}
