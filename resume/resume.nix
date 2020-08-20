conix: 
let
  sortExperiences = builtins.sort (a: b: a.period.start > b.period.start);
  showPeriod = period: "${builtins.toString period.start} - ${builtins.toString (period.end or "present")}";
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

  subsection = title: name: period: content:
    ''
    <div class="subsection">
    ${if title == "" then "" else "#### ${title}"}
    <div class="aligned">
    <span class="left-align">${name}</span>
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
${conix.resume.email} - ${conix.resume.linkedin} - ${conix.resume.github}
</section>

${section "Experience" (sortExperiences conix.resume.experiences) "experience"
  (e: subsection 
    e.position 
    e.instituteName 
    e.period 
    ("* ${builtins.concatStringsSep "\n* " e.duties}")
  )
}

${section "Projects" conix.resume.projects "projects"
  (project: subsection 
      "" 
      project.instituteName
      (builtins.concatStringsSep " " (builtins.map (l: l.languageName) project.projectLanguages))
      project.synopsis
  )
}

${section "Education" conix.resume.schools "" 
  (school: subsection
    school.degree
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
