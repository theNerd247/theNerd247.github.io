let
  pkgs = import ./pkgs.nix;
in
  { site = pkgs.conix.buildPages (
      (import ./resume) ++ 
      [ (c: { drv = with c.lib; collect "zettelkasten" 
          ( [ (c.resume.drv)
              (dir "static" [ ./static ])
              c.index.drv
              (dir "docs" [ c.docs.drv ])
            ]
            ++ (c.pkgs.lib.attrsets.mapAttrsToList (_: m: m.drv) c.posts)
          );
        })
        (c: { docs.drv = c.lib.htmlFile "docs" "" (c.lib.markdownFile "docs" (c.lib.mkDocs c.docs)); })
        (import ./contents/making-a-sandwich.nix)
        (import ./contents/no-vars-js.nix)
        (import ./contents/why-fp-eaql.nix)
        (import ./contents/conix-intro.nix)
        (import ./contents/index.nix)
        (import ./runJs.nix)
        (import ./withDrv.nix)
        (import ./postList.nix)
        (import ./postHtmlFile.nix)
      ]
    );

    resume = pkgs.conix.buildPages (import ./resume);
  }
