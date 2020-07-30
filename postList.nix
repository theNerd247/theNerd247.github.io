conix: 
  conix.foldMapModules 
  (n: 
    if n != "index"
    then conix.bindModule 
      (p: 
        conix.mapVal (t: "* ${t}") (conix.linkTo p.meta.title [p.meta.name])
      ) (conix.at [ "posts" n])
    else conix.emptyModule
  ) 
  (builtins.attrNames conix.pages.posts)
