conix: { resume = rec {
  personalTitle = "Software Engineer";
  firstName     = "Noah";
  lastName      = "Harvey";
  email         = "noah.harvey247@gmail.com";
  github        = "github.com/theNerd247";
  gitHubLink    = "https://${github}";
  linkedInLink  = "https://${linkedin}";
  linkedin      = "linkedin.com/in/noahharvey";
  experiences   = [ delanteGroup genAssembly awakeSecurity ];
  languages = 
      [ linux
        haskell
        nix
        elm
        clang
        csharp
        javascript
        git
      ]; 

  schools = 
      [ { period        = { start = 2012; end = 2017; };
          instituteName = "Kennesaw State University";
          website       = "https://ksu.edu";
          degree        = "B.S. Mechatronics Engineering";
        }
      ];

  projects =
    [ conix
      optparseRepline
      breezeCheck
      ariaRacer
      lambda
      scheduler 
    ];

  publications = 
      [ gtriRigidBodies
      ];


  itcli = {
    instituteName = "itcli";
    website       = "https://github.com/theNerd247/itcli";
    synopsis      = "A CLI issue tracker for small projects";
    projectLanguages = [haskell nix];
  };

  breezeCheck = {
    instituteName = "breeze-check";
    website       = "https://github.com/theNerd247/breeze-check";
    synopsis      = "Mobile first check in system using snap and Elm-Lang";
    projectLanguages = [haskell elm nix];
  };


  lambda = {
    instituteName = "lambda";
    website       = "https://github.com/theNerd247/breeze-check";
    synopsis      = "A tiny lambda calculus interpreter";
    projectLanguages = [ haskell ];
  };

  conix = {
    instituteName = "conix";
    website = "https://github.com/theNerd247/conix";
    synopsis = "A declarative documentation library written in nix.";
    projectLanguages = [ nix ];
  };

  ariaRacer = {
    instituteName = "aria-racer";
    website       = "https://github.com/theNerd247/aria-racer";
    synopsis      = "A robot racing server with a web-based interface using snap.";
    projectLanguages = [ haskell bash docker ];
  };

  resumePortfolio = {
    instituteName = "resume";
    website = "https://github.com/theNerd247/theNerd247.github.io";
    synopsis = "Personal resume and portfolio website builder";
    projectLanguages = [ haskell nix];
  };

  optparseRepline = {
    instituteName = "optparse-repline";
    website = "https://github.com/theNerd247/optparse-repline";
    synopsis = "An Haskell library for creating REPLs using optparse-applicative";
    projectLanguages = [ haskell ];
  };

  scheduler = {
    instituteName = "scheduler";
    website = "https://github.com/theNerd247/theNerd247.github.io";
    synopsis = "An automated scheduling system for teachers.";
    projectLanguages = [ javascript ];
  };


  lessonsNixStore = {
    instituteName = "lessons-nix";
    website = "https://github.com/theNerd247/theNerd247.github.io";
    synopsis = "A nix build system for managing teaching content";
    projectLanguages = [ nix ];
  };


  haskell = {
         languageName       =  "Haskell";
         languageCategories = ["backend" "frontend"];
         yearsExperience    = 4;
   };

  clang = {
         languageName       =  "C";
         yearsExperience    = 7;
         languageCategories = ["backend"];
  };

  cpp = {
         languageName       =  "C++";
         yearsExperience    = 5;
         languageCategories = ["backend"];
  };

  csharp = {
         languageName       =  "C#";
         yearsExperience    = 2;
         languageCategories = ["backend" "frontend"];
  };

  javascript = {
         languageName       =  "JavaScript";
         yearsExperience    = 5;
         languageCategories = ["backend" "frontend"];
  };

  nix = {
         languageName       =  "Nix";
         yearsExperience    = 2;
         languageCategories = ["systems"];
  };

  docker = {
    languageName = "Docker";
    yearsExperience = 1;
    languageCategories = ["systems"];
  };

  elm = {
         languageName       =  "Elm";
         yearsExperience    = 2;
         languageCategories = ["frontend"];
  };

  bash = {
         languageName       =  "Bash";
         yearsExperience    = 4;
         languageCategories = ["shell"];
  };

  fish = {
         languageName       =  "Fish";
         yearsExperience    = 2;
         languageCategories = ["shell"];
  };

  zsh = {
         languageName       =  "Zsh";
         yearsExperience    = 4;
         languageCategories = ["shell"];
  };

  matlab = {
         languageName       =  "Matlab";
         yearsExperience    = 4;
         languageCategories = ["datascience"];
  };

  python = {
         languageName       =  "Python";
         yearsExperience    = 3;
         languageCategories = ["datascience" "backend"];
  };

  linux = {
        languageName       = "Linux";
        yearsExperience    = 8;
        languageCategories = ["backend"];
  };

  git = {
      languageName       = "Git";
      yearsExperience    = 8;
      languageCategories = [];
  };

  awakeSecurity = {
    instituteName = "Awake Security";
    website       = "https://awakesecurity.com/";
    position      = "Functional Programmer Intern";
    period        = { start = 2020; end = 2020; };
    duties        =
      [ "Invented Conix - an open source project for creating bug free documentation written in Nix."
        "Created the optparse-repline open source Haskell library to aid in
        refactoring a large codebase and eliminate production bugs as well as
        stablize a user interface."
        "Designed tutorials for EAQL - a new programming language invented by Awake Security."
      ];
  };


  genAssembly = {
    instituteName = "General Assembly";
    website       = "https://generalassemb.ly/locations/atlanta";
    position      = "Lead Instructor";
    period        = { start = 2018; end = 2019; };
    duties        =
        [ "Lead 60 career-changing students in three 12-week immersive courses using JavaScript Python MongoDB and SQL with a 90% job placement rate."
         "Designed and implemented Git architecture for managing course curriculum which eliminiated work duplication and increased clear team communication."
         "Designed prototyped and built course scheduling system using functional programming to decrease course planning time from 1 week to half a day."
        ];
  };

  ksuTA = {
    instituteName = "Kennesaw State University Mechatronics Dept.";
    website       = "https://engineering.kennesaw.edu/mechatronics/index.php";
    position      =  "Teaching Assistant";
    period        = { start = 2016; end = 2017; };
    duties        =
        [ "Developed a web server in Haskell to manage a robot race competition."
         "Used embedded C programming to design tools for students."
         "Lead and instructed embedded software and robotics lab."
        ];
  };

  gtri = {
    instituteName = "Georgia Tech Research Institute";
    website       = "https://www.gtri.gatech.edu/";
    position      = "Robotics Software Engineer Co-Op";
    period        = { start = 2015; end = 2016; };
    duties        =
        [ "Contributed to the completion of an automated poultry de-boning project designed to increase factory processing speed by 80%."
         "Designed graphical tool using C++ to enable research scientists to easily capture and process data relevant to projects."
        ];
    otherSkills =
        [ "Contributed to on going research projects within a week of on-boarding using image processing algorithms in C++."
         "Contributed to the completion of a 5 year prototyping project for top industry client in poultry processing."
         "Introduced the Robotic Operating System framework to new projects to increase modularity and increase."
        ];
  };

  uniq = {
    instituteName = "UNIQ Technologies Inc.";
    website       = "";
    position      = "Mechatronics Engineer Intern";
    period        = { start = 2014; end = 2014; };
    duties        =
        [ "Designed embedded software for small engine control systems."
          "Designed and prototyped digital microcontroller circuits."
          "Aided in brainstorming new company products."
        ];
  };

  delanteGroup = {
    instituteName = "Delante Group Inc.";
    website       = "http://www.delantegroup.com/";
    position      = "Full Stack Software Engineer";
    period        = { start = 2017; end = 2018; };
    duties        =
        [ "Designed handwriting to text automation process using AWS MTURK to decrease operation costs from approximately 1k per month to approximately $100 per month."
          "Wrote a C# to TypeScript transpiler to increase cross language type-safety between frontend and backend code."
          "Increased client facing productivity by ensuring minimal downtime of MongoDB servers."
        ];
  };

  gtriRigidBodies = {
    publicationAuthors =
        [ { firstName = "Ai Ping"; lastName  = "Hu"; }
          { firstName = "Noah"; lastName     = "Harvey"; }
          { firstName = "Clarence"; lastName = "Washington"; }
        ];
    publicationTitle   = "Motion Control Of Articulated Rigid Bodies Used To Model Deformable Biomaterials";
    publicationYear    = 2016;
    publisher          = "IEEE International Conference on Advanced Intelligent Mechatronics";
  };

  personalAttributes =
    [ "problem solver"
     "mathematical thinker"
     "curious explorer"
    ];
}; }