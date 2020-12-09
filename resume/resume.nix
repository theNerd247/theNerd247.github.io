conix: with conix;

let
  sortExperiences = 
    builtins.sort (a: b: sortTime a.period.start b.period.start);

  showPeriod = period: "${timeToString period.start} - ${timeToString (period.end or null)}";

  showAuthors = authors:
    let
      prim = builtins.head authors;
    in
      "${prim.lastName}, ${prim.firstName}${if builtins.length authors > 1 then " et al." else ""}";

  section = title: contents: [
    ''
    <section class="section ''(pkgs.lib.toLower title) ''">
    ### '' title ''

    <div class="section-contents">

    '' contents ''

    </div>
    </section>

  ''];

  subsection = topLeft: topRight: bottomLeft: bottomRight: content: [
    "<div class=\"subsection pageBreak\">"

    "<div class=\"aligned\">"
      "<span class=\"left-align\">"
        (if topLeft == "" then [] else ["<h4>" topLeft "</h4>"])
      "</span>"
      "<span class=\"right-align\">" topRight "</span>"
    "</div>"
    "<div class=\"aligned\">"
      "<span class=\"left-align italic\">" bottomLeft "</span>"
      "<span class=\"right-align\">"
        bottomRight
      "</span>"
     "</div>"

     "<div class=\"content\">\n\n"
       content
     "\n\n</div>"
    "</div>"
    ];

  article = class: content: [
    ''
    <article class='' class ''>

    '' content ''

    </article>
    ''
  ];
in

markdown "resume" (html "resume" [
  (meta [
    [''
      css: 
        ''#- ''(pathOf ./static/latex.css)"\n"
        "  - "(pathOf ./static/main.css)
    ]
    "pagetitle: Resume - Noah Harvey"
  ])


''<h1 class="title">'' (r data.resume.firstName)" "(r data.resume.lastName)''</h1>

<section class="subtitle">
''(r data.resume.objective)''
</section>

''
(article "main" [

  (article "sidebar" [
    (section "Languages" 
      (r (intersperse " - " (builtins.map 
        (l: l.languageName) 
        data.resume.languages
      )))
    )
    
    (section "Contact" (list [

      (r data.resume.email)
      (r data.resume.phone)
      (r data.resume.linkedin)
      (r data.resume.github)

    ]))
  ])

  (article "main-content" [

    (section "Experience" 
      (r (with builtins; map
        ({position, hireType, instituteName, period, duties, ...}: subsection 
          position
          hireType
          instituteName 
          (showPeriod period) 
          (list duties)
        )
        (sortExperiences data.resume.experiences)
      ))
    )

    (section "Projects" 
      (r (with builtins; map
        (project: subsection 
            "" 
            ""
            project.instituteName
            (concatStringsSep " " (map (l: l.languageName) project.projectLanguages))
            project.synopsis
        )
        data.resume.projects
      ))
    )

    (section "Education" 
      (r (with builtins; map
        (school: subsection
          school.degree
          school.hireType
          school.instituteName
          (showPeriod school.period)
          ""
        )
        data.resume.schools 
      ))
    )

    (section "Publications"
      (r (with builtins; map
        (publication:
          ''
          <span class="publication-item">
          ${showAuthors publication.publicationAuthors} _${publication.publicationTitle}_ ${builtins.toString publication.publicationYear}, ${publication.publisher}
          </span>
          ''
        )
        data.resume.publications 
      ))
    )

    ])

])

])
