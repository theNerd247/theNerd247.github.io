rec
{
  researchers = 
  [
    { name = "Richard Statman";
      topics = 
      [
        "Typed lambda calculus and its extensions"
        "Evaluation, reduction and conversion strategies"
        "Combinators and combinatory algebra"
        "Computability of functions and invariants"
        "Functional equations and unification"
        "Connections to other branches of mathematics such as semigroup theory"
      ];
      institute = "CMU";
    }
    { name = "Steve Awodey";
      topics = 
      [
        "Category Theory"
        "Logic"
        "Philosophy of Mathematics"
      ];
      institute = "CMU";
    }
    {
      name = "Stephanie Balzer";
      topics = 
      [
      ];
    }
    { name = "Robert Harper";
      institute = "CMU";
    }
    { name = "Paul Downen";
      institute = "University of Oregon";
    }
  ];

  upenn = 
  { greCode = 2888;
    applicationProcess =
      [ "Biographical information (part of the online application)"
        "Resume"
        { PersonalStatement = 
          [ ''
            We recommend the following guidelines for the personal statement:
            No more than two pages in a readable font/size:
            ''
            "Why are you interested in this program?"
            "What have you done that makes you a great candidate?"
            "How will you benefit from the program?"
            "How do you plan to contribute to the student community in SEAS while you’re here?"
            "Why will you succeed in the program?"
            "What will you do/accomplish once you have completed the program?"
          ];
        }
        "CIS PhD application requires three [3] Letters of Recommendation."
        "Unofficial Transcript submitted"
        "$80 non-refundable application fee" 
      ];
  };
}
