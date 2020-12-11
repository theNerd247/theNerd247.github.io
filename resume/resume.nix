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

  wrapped = before: content: after: if isEmpty content then [] else [ before content after ];

  section = title: contents: [
    ''
    <section class="section ''(pkgs.lib.toLower title) ''">
    ### '' title ''

    <div class="section-contents">

    '' contents ''

    </div>
    </section>

  ''];

  subsection = title: subTitle: content: 
    wrapped 
      "<div class=\"subsection pageBreak\">"
      [ (wrapped "<h4>" title "</h4>")
        (wrapped ''<div class="subsection-subtitle">'' subTitle 
          ''</div>

        
          ''
        )
        (wrapped ''<div class="subsection-content">'' content ''</div>'')
      ]
      "\n\n</div>";

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
    
    (section "Contact" (list [

      (r data.resume.email)
      (r data.resume.phone)
      (r data.resume.linkedin)
      (r data.resume.github)

    ]))

    (section "Languages" 
      (r (intersperse ", " (builtins.map 
        (l: l.languageName) 
        data.resume.languages
      )))
    )

    (section "Projects" 
      (r (with builtins; map
        (project: subsection project.projectName "" project.synopsis)
        data.resume.projects
      ))
    )
  ])

  (article "main-content" [

    (section "Experience" 
      (r (with builtins; map
        ({position, hireType, instituteName, period, duties, ...}: subsection 
          position
          (intersperse ", " [(showPeriod period) instituteName hireType ])
          (list duties)
        )
        (sortExperiences data.resume.experiences)
      ))
    )

    (section "Education" 
      (r (with builtins; map
        (school: subsection
          school.degree
          (intersperse ", " [(showPeriod school.period) school.instituteName])
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
