let
  fileBaseNameOf = fp: builtins.elemAt (builtins.splitVersion (builtins.baseNameOf fp)) 0;
in
x: with x; module "## Post API"
{
  postHtmlFile = expr
    "FileBaseName -> Content -> Content"
    ''
    Create an HTML blog post and nest its content under the given file's
    basename
    ''
    (fileBaseName: content: x: with x; html fileBaseName [
      (meta [
        (css ./static/zettelkasten.css)
        ["pagetitle: \""(r (data.${fileBaseName}.title or fileBaseName))"\""]
      ])''



      ''(nest fileBaseName content)
    ])
    ;

  importPostFile = expr
    "FilePath -> Content"
    "Import the given content from a file as a HTML Blog post"
    (fp: data.postHtmlFile (fileBaseNameOf fp) (import fp))
    ;

  importPostsDir = expr
    "DirPath -> Content"
    "Import all the posts under the given dir"
    (dirPath: with builtins;
      let
        linksAndFiles = foldAttrsIxCond 
        (_: false)
        (fileType: filePath:
          let
            fileName = concatStringsSep "." filePath;
            fbn = fileBaseNameOf fileName;
          in
          if fileType == "regular" then 
            { 
              fst = x: ["[" (_ref x.data.${fbn}.title) "](./${fbn}.html)" ];
              snd = data.importPostFile (./. + "/${dirPath}/${fileName}");
            }
          else []
        )
        (cs: foldl' (as: a: { fst = as.fst ++ [a.fst]; snd = as.snd ++ [a.snd];}) { fst = []; snd = []; } (attrValues cs))
        (readDir (./. + "/${dirPath}"));

        dname = fileBaseNameOf dirPath;
      in
       [ (_tell { ${dname}.links = linksAndFiles.fst; })
         linksAndFiles.snd
       ]
    )
    ;

}
