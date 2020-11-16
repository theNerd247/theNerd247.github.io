let
  fileBaseNameOf = fp: with builtins; elemAt (splitVersion (baseNameOf fp)) 0;
in
x: with x; module (_: [])
{
  postHtmlFile = expr
    "FileBaseName -> Content -> Content"
    ''
    Create an HTML blog post and nest its content under the given file's
    basename
    ''
    (fileBaseName: content: x: with x; { ${fileBaseName} = html fileBaseName [
      (meta [
        (css ./static/zettelkasten.css)
        ["pagetitle: \""(r (data.${fileBaseName}.title or fileBaseName))"\""]
      ])''


      ''(nest fileBaseName content)
    ]; })
    ;

  importPostFile = expr
    "FilePath -> Content"
    "Import the given content from a file as a HTML Blog post"
    (fp: exprs.postHtmlFile (fileBaseNameOf fp) (import fp))
    ;

  # TODO: make the dir import generic enough to be part of the core library
  # TODO: add linking mechanism to the core library to simplify this code
  importPostsDir = expr
    "DirPath -> Content"
    "Import all the contents under the given dir"
    (dirPath: with builtins;
        foldAttrsIxCond 
        (_: false)
        (fileType: filePath:
          let
            fileName = concatStringsSep "." filePath;
            fbn = fileBaseNameOf fileName;
            ext = builtins.match ".*.nix$" fileName;
          in
            if fileType == "regular" && ext == [] then exprs.importPostFile (./. + "/${dirPath}/${fileName}")
            else []
        )
        (attrValues)
        (readDir (./. + "/${dirPath}"))
    )
    ;
}
