conix: { lib = rec { 
  docs.postHtmlFile.docstr = ''
    Creates an html file as the `drv` for a module.

    This is specific to the zettelkasten as it has a hardcoded css path.
  '';
  docs.postHtmlFile.todo = [
    "When upstreaming this into conix it'd be best to remove the hardcoded css path"
  ];
  docs.postHtmlFile.type = "Name -> String -> Module -> Module";
  postHtmlFile = name: args: with conix.lib;
    withDrv (m: 
      htmlFile name "--css ./static/zettelkasten.css ${args}" 
        (markdownFile name m)
    );
};}
