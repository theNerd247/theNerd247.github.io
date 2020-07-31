postMeta: content: conix:
conix.texts [ "posts" postMeta.name ]
  ((content conix)
    ++ [(conix.hidden (conix.setValue [ "meta" ] postMeta))]
  )

