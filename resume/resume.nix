conix: 
let
  at = p: conix.at ([ "portfolio"] ++ p);
  textIf = p: f: t: 
    if f then conix.text p t else conix.emptyModule;
in

conix.texts [] [
"# "(at ["firstName"])" " (at ["lastName"])

(conix.bindModule 
  (conix.foldMapModules
    (experience: conix.texts [experience.instituteName] [
      ''* ${experience.position}
        * ${experience.instituteName}
        * ''
      (conix.text [ "period" "start" ] experience.period.start)" - "
      (conix.text ["period" "end" ] 
        (experience.period.end or "present")
      )
      (conix.foldMapModulesIx 
        (ix: duty: conix.text [ "duty${ix}" ] "  * ${duty}") 
        experience.duties
      )
    ])
  )
  (at ["experiences"])
)
]
