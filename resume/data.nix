x: with x; tell { 

  resume = rec {
    personalTitle = "Software Engineer";
    firstName     = "Noah";
    lastName      = "Harvey";
    phone         = "678-896-5165";
    email         = "noah.harvey247@gmail.com";
    github        = "github.com/theNerd247";
    gitHubLink    = "https://${github}";
    linkedInLink  = "https://${linkedin}";
    linkedin      = "linkedin.com/in/noahharvey";
    experiences   = 
      [
        awakeSecurity
        delanteGroup
        genAssembly
        gtri
        kollaCode
        ksuTA
        uniq
      ];
    languages = 
        [ 
          haskell
          nix
          elm
          c
          cpp
          csharp
          javascript
          java
          git
          bash
          python
        ]; 

    schools = 
      [ 
        { period        = { start = time 8 2012; end = time 5 2017; };
          instituteName = "Kennesaw State University";
          hireType      = "Full Time";
          website       = "https://ksu.edu";
          degree        = "B.S. Mechatronics Engineering";
          gpa           = 3.44;
        }
      ];

    projects =
      [ 
        optparseRepline
        breezeCheck
        ariaRacer
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

    c = {
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

    java = {
      languageName = "Java";
      yearsExperience = 4;
      languageCategories = [ "backend" ];
    };

    awakeSecurity = {
      instituteName = "Awake Security";
      website       = "https://awakesecurity.com/";
      position      = "Software Engineer";
      hireType      = "Full Time";
      period        = { start = time 3 2020; end = time 9 2020; };
      duties        =
        [ 
          ''
          Invented a domain specific language called `conix` to program
          technical documents. This language made it possible to author
          tutorials that were always up to date.
          ''

          ''
          Layed the foundation for a large codebase refactor by writing an
          open-source Haskell library. This refactor provided the means to
          fix major bugs in our product and implement new features.
          ''
        ];
    };

    kollaCode = {
      instituteName = "Kolla Code";
      website = "http://kollacode.com/";
      position = "Software Engineer";
      hireType = "Contractor";
      period = { start = time 10 2019; end = time 3 2020; };
      duties =
        [ 
          ''
          Co-lead a new project's program architecture and introduced
          Typescript to the team which increased overall team proficency.
          ''

          ''
          Introduced best practices for using Git and Github to the company.
          ''

          ''
          Invented declarative authorization-key management system. This
          drastically increased developer productivity by making application
          builds predictable.
          ''
        ];
    };


    genAssembly = {
      instituteName = "General Assembly";
      website       = "https://generalassemb.ly/locations/atlanta";
      position      = "Software Engineering Lead Instructor";
      hireType      = "Full Time";
      period        = { start = time 10 2018; end = time 10 2019; };
      duties        =
          [ 
            "Lead 60 career-changing students in three 12-week immersive courses using JavaScript, Python, MongoDB, and SQL with a 90% job placement rate."
            "Designed and implemented Git architecture for managing course curriculum which eliminiated work duplication and increased clear team communication."
            "Designed, prototyped and built a course scheduling system to decrease course planning time from 1 week to half a day."
            "Authored web development curriculum and exercises for junior developers using Express, MongoDB, NodeJS, and React JS."
          ];
    };

    ksuTA = {
      instituteName = "Kennesaw State University Mechatronics Dept.";
      website       = "https://engineering.kennesaw.edu/mechatronics/index.php";
      position      = "Teaching Assistant";
      hireType      = "Part Time";
      period        = { start = time 8 2016; end = time 12 2017; };
      duties        =
          [ "Developed a web server in Haskell to manage a robot race competition."
           "Used embedded C programming to design tools for students."
           "Lead and instructed embedded software and robotics lab."
          ];
    };

    gtri = {
      instituteName = "Georgia Tech Research Institute";
      website       = "https://www.gtri.gatech.edu/";
      position      = "Robotics Engineer";
      hireType      = "Co-op";
      period        = { start = time 1 2015; end = time 7 2016; };
      duties        =
          [ 
           "Designed and implemented robotics control software for an automated poultry de-boning project designed to increase factory processing speed by 80%."
           "Wrote computer vision software to collect statistics for modelling the skeleton of poultry."
           "Introduced the Robotic Operating System framework and GitLab to new projects which created a stable."
           "Co-Authored a research paper on modelling the kinematics of non-rigid bodies"
          ];
    };

    uniq = {
      instituteName = "UNIQ Technologies Inc.";
      website       = "";
      position      = "Mechatronics Engineer";
      hireType      = "Internship";
      period        = { start = time 5 2014; end = time 7 2014; };
      duties        =
          [ 
            "Designed embedded software for a small engine control system."
            "Designed, built, and programmed motor controller circuit boards from reciept printers."
            "Aided in quality control of auto parts"
          ];
    };

    delanteGroup = {
      instituteName = "Delante Group Inc.";
      website       = "http://www.delantegroup.com/";
      position      = "Full Stack Software Engineer";
      hireType      = "Full Time";
      period        = { start = time 5 2017; end = time 10 2018; };
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
