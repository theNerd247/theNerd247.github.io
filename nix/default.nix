with (import ./nixpkgs.nix);

let
  pandoc-tags = haskellPackages.pandoc-tags;

  noah-zettelkasten = stdenv.mkDerivation
  { name = "noah-zettelkasten";
    src = ./.;
    buildInputs = [ pandoc-tags ];
    buildPhase = 
      ''
      #build the index.md file
      #TODO: integrate with pandoc-tags? 
      rm -f md/index.md

      for f in md/*.md; do 
        name=$(echo $f | sed -e 's/.md\|md\///g')
        link="$name".html
        echo "* [$name]($link)" >> md/index.md
      done

      ${pandoc-tags}/bin/pandoc-tags ./md/*.md
      '';

    installPhase =
      ''
      mkdir -p $out
      cp ./md/*.html $out/
      cp -r ./static $out/static
      '';
  };
in
{ inherit noah-zettelkasten;
  inherit pandoc-tags-shell;
}
