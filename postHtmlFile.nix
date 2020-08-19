conix: { lib = rec { 
  postHtmlFile = name: args: with conix.lib;
    withDrv (m: 
      htmlFile name "--css ./static/zettelkasten.css ${args}" 
        (markdownFile name m)
    );
};}
