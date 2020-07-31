conix: 
  conix.foldMapModules 
  (n: 
    if n != "index"
    then conix.bindModule 
      (p: 
        conix.pureModule "* [${p.meta.title}](./${p.meta.name}.html)"
      ) (conix.at [ "posts" n])
    else conix.emptyModule
  ) 
  (builtins.attrNames conix.pages.posts)
