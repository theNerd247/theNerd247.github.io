conix: 
let
  at = p: conix.at ([ "portfolio"] ++ p);
  textIf = p: f: t: 
    if f then conix.text p t else conix.emptyModule;
in

conix.texts [] [
"# "(at ["firstName"])" " (at ["lastName"])

(conix.moduleUsing ["experiences"] [ "portfolio" "experiences"] 
  (es: conix.texts [] (builtins.map 
    (e: conix.texts [e.instituteName] [
      ''

        # ${e.position}
        * ${e.instituteName}
        * ${builtins.toString e.period.start} - ${builtins.toString (e.period.end or "present")}

      ''
      (conix.texts ["duties"] (builtins.map (d: "    * ${d}\n") e.duties))
    ])
    es)
  )
)
]
