conix: 
let
  sortExperiences = 
    builtins.sort (a: b: conix.lib.sortTime a.period.start b.period.start);
  showPeriod = period: "${conix.lib.timeToString period.start} - ${conix.lib.timeToString (period.end or null)}";
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
    <div class="subsection">

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
{ resume = conix.lib.text 
''# ${conix.resume.firstName} ${conix.resume.lastName}

<section class="contact">
${conix.resume.email} - ${conix.resume.phone} - ${conix.resume.github}
</section>

${section "Experience" (sortExperiences conix.resume.experiences) "experience"
  (e: subsection 
    e.position
    e.hireType
    e.instituteName 
    e.period 
    ("* ${builtins.concatStringsSep "\n* " e.duties}")
  )
}

${section "Projects" conix.resume.projects "projects"
  (project: subsection 
      "" 
      ""
      project.instituteName
      (builtins.concatStringsSep " " (builtins.map (l: l.languageName) project.projectLanguages))
      project.synopsis
  )
}

${section "Education" conix.resume.schools "" 
  (school: subsection
    school.degree
    school.hireType
    school.instituteName
    school.period
    ""
  )
}

${section "Publications" conix.resume.publications ""
  (publication:
    ''
    <span class="publication-item">
    ${showAuthors publication.publicationAuthors} _${publication.publicationTitle}_ ${builtins.toString publication.publicationYear}, ${publication.publisher}
    </span>
    ''
  )
}
'';}
