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
        ["pagetitle: \""(r (data.posts.${fileBaseName}.title or fileBaseName))"\""]
      ])''



      ''(nest fileBaseName content)
    ])
    ;

  importPostFile = expr
    "FilePath -> Content"
    "Import the given content from a file as a HTML Blog post"
    (fp: 
      let
        fileBaseName = builtins.elemAt (builtins.splitVersion (builtins.baseNameOf fp)) 0;
      in
        data.postHtmlFile fileBaseName (import fp)
    )
    ;

  importPostsDir = expr
    "DirPath -> Content"
    "Import all the posts under the given dir"
    (dirPath:
      foldAttrsIxCond 
        (_: false)
        (fileType: fileName: 
          if fileType == "regular" then importPostFile (./. "/${dirPath}/${fileName}")
          else []
        )
        builtins.attrValues
        (builtins.readDir dirPath)
    )
    ;

}
