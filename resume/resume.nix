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

  section = title: dataPath: pre: class: itemContent:
    conix.texts [] [
      ''
      <section class="section ${class}">
      ### ${title}
      <div class="section-contents">
      ''
      (conix.moduleUsing [title] dataPath 
        (es: for [] (pre es)
          (e: conix.texts [e.instituteName] (itemContent e))
        )
      )
      ''
      </div>
      </section>
      ''
    ];

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

conix.texts [] [
"# "(at ["firstName"])" "(at ["lastName"])''

<section class="contact">
''(conix.at ["portfolio" "email"])" - "(conix.at ["portfolio" "linkedin"])" - "(conix.at ["portfolio" "github"])
''
</section>

''
(section "Experience" ["portfolio" "experiences"] sortExperiences "experience" (experience: [

  (subsection 
    experience.position 
    experience.instituteName 
    experience.period 
    ("* ${builtins.concatStringsSep "\n* " experience.duties}")
  )
]))

(section "Projects" ["portfolio" "projects"] (x: x) "projects" (project: [
  (subsection 
      "" 
      project.instituteName
      (builtins.concatStringsSep " " (builtins.map (l: l.languageName) project.projectLanguages))
      project.synopsis
  )
]))

(section "Education" ["portfolio" "schools"] (x: x) "" (school: [
  (subsection
    school.degree
    school.instituteName
    school.period
    ""
  )
]))

(section "Publications" ["portfolio" "publications"] (x: x) "" (publication: [
''
<span class="publication-item">
${showAuthors publication.publicationAuthors} _${publication.publicationTitle}_ ${builtins.toString publication.publicationYear}, ${publication.publisher}
</span>
''
]))

]
