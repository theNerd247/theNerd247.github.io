conix: 
let
  at = p: conix.at ([ "portfolio"] ++ p);
  for = path: xs: f: conix.texts [] (builtins.map f xs);
  sortExperiences = builtins.sort (a: b: a.period.start > b.period.start);
  showPeriod = period: "${builtins.toString period.start} - ${builtins.toString (period.end or "present")}";
  showAuthors = authors:
    let
      prim = builtins.head authors;
    in
      "${prim.lastName}, ${prim.firstName}${if builtins.length authors > 1 then " et al." else ""}";
in

conix.texts [] [
"# "(at ["firstName"])" "(at ["lastName"])''

## Experience
''

(conix.moduleUsing ["experiences"] [ "portfolio" "experiences"] 
  (es: for [] (sortExperiences es)
    (experience: conix.texts [experience.instituteName] [
''

### ${experience.position}

  * ${experience.instituteName}
  * ${showPeriod experience.period}

''
      (for ["duties"] experience.duties (d: 

"    * ${d}\n"

      ))
    ])
  )
)''

## Relevant Projects

''
(conix.moduleUsing ["projects"] ["portfolio" "projects"]
  (projects: for [] projects
    (project: conix.texts [project.instituteName] [
''
#### ${project.instituteName}
  * ''
      (for [project.instituteName] project.projectLanguages
        (language: conix.text [] "${language.languageName} ")
      )
''


${project.synopsis}

''
    ])
  )
)
''

## Education

''
(conix.moduleUsing ["education"] ["portfolio" "schools"]
  (schools: for [] schools
    (school: conix.text [school.instituteName]
''

### ${school.degree}

  * ${school.instituteName}
  * ${showPeriod school.period}
''
    )
  )
)
''

## Publications

''
(conix.moduleUsing ["publications"] ["portfolio" "publications"]
  (publications: for [] publications
    (publication: conix.text []
''
  * ${showAuthors publication.publicationAuthors} _${publication.publicationTitle}_ ${builtins.toString publication.publicationYear}, ${publication.publisher}
''
    )
  )
)

]
