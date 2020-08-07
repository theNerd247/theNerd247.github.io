filterDrafts: conix: 
  conix.foldMapModules 
  (n: 
    if n != "index"
    then conix.bindModule 
      (p: 
        if 
           filterDrafts == (builtins.head p.meta.tags  == "draft")
        then conix.emptyModule
        else conix.pureModule "* [${p.meta.title}](./${p.meta.name}.html)\n"
      ) (conix.at [ "posts" n])
    else conix.emptyModule
  ) 
  (builtins.attrNames conix.pages.posts)
