postMeta: content: conix:
conix.texts [ "posts" postMeta.name ]
  (content 
    ++ [(conix.hidden (conix.setValue [ "meta" ] postMeta))]
  )

