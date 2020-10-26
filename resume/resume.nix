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

  section = title: data: class: itemContent:
    ''
    <section class="section ${class}">
    ### ${title}
    <div class="section-contents">

    ${builtins.concatStringsSep "" (builtins.map itemContent data)}

    </div>
    </section>
    '';

  subsection = title: hireType: name: period: content:
    ''
    <div class="subsection pageBreak">

    <div class="aligned"> <span class="left-align"> ${if title == "" then "" else "<h4>${title}</h4>"} </span> <span class="right-align">${hireType}</span> </div>
    <div class="aligned">
      <span class="left-align italic">${name}</span>
      <span class="right-align">
      ${if builtins.isAttrs period
        then
          showPeriod period
        else
          period
       }
       </span>
     </div>

     <div class="content">
     ${content}
     </div>
    </div>
    '';
in

markdown "resume" (html "resume" [
  (meta [
    [''
      css: 
        - ''(pathOf ./static/latex.css)"\n"
        "  - "(pathOf ./static/main.css)
    ]
    "pagetitle: Resume - Noah Harvey"
  ])

(r ''# ${data.resume.firstName} ${data.resume.lastName}

<section class="contact">
${data.resume.email} - ${data.resume.phone} - ${data.resume.github}
</section>

${section "Experience" (sortExperiences data.resume.experiences) "experience"
  (e: subsection 
    e.position
    e.hireType
    e.instituteName 
    e.period 
    ("* ${builtins.concatStringsSep "\n* " e.duties}")
  )
}

${section "Projects" data.resume.projects "projects"
  (project: subsection 
      "" 
      ""
      project.instituteName
      (builtins.concatStringsSep " " (builtins.map (l: l.languageName) project.projectLanguages))
      project.synopsis
  )
}

${section "Education" data.resume.schools "" 
  (school: subsection
    school.degree
    school.hireType
    school.instituteName
    school.period
    ""
  )
}

${section "Publications" data.resume.publications ""
  (publication:
    ''
    <span class="publication-item">
    ${showAuthors publication.publicationAuthors} _${publication.publicationTitle}_ ${builtins.toString publication.publicationYear}, ${publication.publisher}
    </span>
    ''
  )
}
'')
])
