# Instructions
# Prepare a concise one or two page essay in PDF format that describes your
# primary areas of interest, your related experiences, and your objective in
# pursuing a graduate degree at Carnegie Mellon. 
#
# Your essay should be specific
# in describing your interests and motivations. When describing your interests,
# you should explain : 
#
#  * why you think they are important areas of study 
#  * why you are particularly well-suited to pursue them. 
# 
# You should describe any
# relevant education, research, commercial, government, or teaching experience.
#
#
# If you are applying to more than one program, you may (but are not required
# to) submit a separate Statement of Purpose for each program. If you are
# submitting different statements, please upload as one file and include a
# table of contents page. Include your name and User ID on the essay

conix: with conix; [ (pdf "sop" [''

As a PhD student at Carnegie Mellon I intend to study how to use mathematical
models to design and implement domain specific languages.  Particularly I am
interested in using category theory, type theory, and the lambda calculi to
construct denotational semantics of functional programming languages.

''#TODO: shorten this?  

'' My interest in the use of math driven programming language design arose out
of my practical experience as a software engineer. While working at a company
that handled financial data for large corporations I had to solve problems
directly related to the customer's experience. These problems had their roots
directly tied to the existence of non-idiomatic libraries that did not have
well defined behavior. Since then I've learned the enormous benefit of model
driven development. I began to study category theory and lambda calculus in
order to better understand how programming languages were constructed in hopes
of discovering better techniques for designing program APIs and applications.
I have come to realize that most APIs are small languages and
applications are compositions of statements written in those languages. Since
APIs are languages and good languages have some underlying mathematical model
it only makes sense to study languages and their modelling to then develop
industrial strength APIs. 

In my study of programming language design I have began reading Benjamin
Pierce's _Types and Programming Languages_ to understand how type systems are
constructed and basic type theory. Further I have watched the _Programming with
Categories Course_ by David Spivak, Bartosz Milewski, and Brandon Fong and am
making my way through _Categories for Programmers_. While I do not have a
formal background in mathematics I have have spent many hours since my
bachelor's degree studying basic abstract algebra and set theory - at least
enough to help in my day job.

Aside from my hunger for understanding the concepts behind programming language
design I have experience both in research and as a classroom instructor. I
worked as a software engineering instructor for a bootcamp. There I learned how
to instruct adults and used non-conventional teaching methods to bring students
from no knowledge of programming to being junior software engineers. Prior to
this I worked as a TA for a professor in the robotics department. There I
taught an introductory embedded C seminar and ran the lab that corresponded to
that course. Finally, as an undergraduate I worked at the Georgia Tech Research
Institute as a robotics software engineer co-op. There I aided in writing a
research paper on the kinematics of non-rigid bodies and wrote the software
that drove a robot that could debone poultry.

'' 

#Industrial
#strength code is very similar in nature to a programming language. I've
#learned that most applications are designed such that a majority of their
#codebase is refactored into libraries and composed together to create a final
#application. These libraries should be idiomatic in their API design, well
#tested, and as bug-free as possible. Most developers, without realizing it,
#create small programming languages (a.k.a idiomatic libraries), write
#expressions in these languages (a.k.a applications), and then evaluating these
#expressions in (a.k.a run or test their applications). When a developer can
#construct an accurate mathematical model of their language the safer the
#program, and the better the performance will be.
#
#
#
#  * GTRI - emersed in writing research based software
#  * GA - instructing students; writing curriculum; developing a deeper
#    understanding of web technologies 
#  * Delante Group - experience as a software engineer and realizing the
#    importance of type safety.
#
#  Personal Experience
#
#    * study of category theory in its application to programming
#    * construction of the eDSL conix
#    * construction of DSL for budgeting
#''
])

# While working as a co-op at the Georgia Tech Research Institute I had the
# opportunity to work on a project involving a robotic arm weilding a knife
# blade to debone chicken carcasses. The program was written largely in C++ as
# well as in a propriatary language akin to a crude FORTRAN. The program
# involved everything from 3-d image processing, multi-threading, memory
# management and high-level process logic. Testing was a nightmare and due to a
# tight budget time couldn't be spent on properly following programming best
# practices.  However, safety was a large factor in how the code was designed
# as well as in testing. While we didn't have one then a proper mathematical
# models and an eDSL would have made the project cost less and involve fewer
# broken parts.  Thankfully no humans were physically injured - just a lot of
# chicken carcasses.
# 
# I was once working at a company that handled processesing transactions
# between large coorporations and banks. The codebase was a mess and therefore
# more than necessary resources were used to fix bugs and ad hocly fullfill
# customer requests. This made it very difficult to add new features to the
# product and even ended in thousands of records being accidentaly deleted from
# the database - and took 2 days to manually recover. If only writing eDSLs and
# modells were easier for business related tasks...
# 
# Finally when a library is an eDSL (or a DSL is being used) then programmers
# that are new to a project have a smaller learning curve. Joinging a project
# involves understanding the languages that are being used and how those
# languages are being worked together to solve problems. This makes it very
# clear where, when, and how a programmer can contribute to the given project.
# 
# My interest with DSLs has led me to pursue a PhD in Computer science at
# Carnegie Mellon. Particularly I am interested in how to design, construct,
# and mathematically model programming languages. And more particularly I am
# interested in using category theory as a foundation for modelling, and
# designing programming languages.

# Outside of my academic interest I have spent a lot of time teaching
# introductory courses on programming. While an undergraduate student
# I was a teachers assistant where I taught an introduction to C lab
# and led a lab in micro-controller programming.
# 
# After my first software engineering job I was hired at General Assembly where I
# taught a software engineering course to students who never programmed before.
# The purpose of the course was to prepare the students for entry level positions
# as software engineers. There I learned how to communicate to adult students,
# design course material, and encourage students to push themselves to higher
# careers.
# 
# I like to share my ideas with others and have started mentoring a college
# student in software engineering. 
# 
# Alongside teaching and peer mentoring I have been working my way through
# category theory For Programmers by Bartosz Milewski and _Types and Programming
# Languages_ by Benjamin Pierce. I have a desire to be constantly learning and
# exploring new ideas.
# 
# To apply the concepts that I have learned I have begun writing a eDSL using the
# Nix programming language that brings high-order logic into text formatting
# languages like markdown and LaTeX. As part of writing this language I have 
# found the usefullness of modelling a languages using category theory.

(pdf "notes" ''
* What am I interested in?

  - Language Design

    - Quality code is idiomatic code 
    - Idiomatic code is a language (no matter how small)
    - Small, composable DSLs makes it easier to write flexible code

  - Mathematical Models

  - What led me to category theory?

    - Learning Haskell 
    - category theory as a math background for modeling and reasoning about programs.
    - Using category theory to drive design of APIs

- Background in robotics?

  - category theory
    
    - how category theory applies to programming and the development of
      programming languages 

    - generally - mathematical models for writing programs.

    - Why interest in mathematical models?

      - concise and idiomatic APis
      - ensures correct behavior of programs
      - writing programs that are easily refactored. 

  * Why do I think they are important?

  * Why am I well suited to pursue these interests? 

    * What evidence of me having the capacity of performing research?
    * What efforts have I already taken to study the areas I'm interested in?
    * Do I have an interest in sharing my thoughts with others and teaching?

* Applications of category theory to the development of programming languages
and programs
* Writing well documented code. 
* Teaching and mentoring others 


 * Interested in writing well organized code and idiomatic APIs
 * Category theory has helped in modelling these APIs
 * Creating accurate models is important for implementing correct,
   refactorable, and well documented code.
 * I am interested in how category theory can be used as a domain for
 modelling programming languages and the construction of APIs and DSLs.

   * Read category theory For Programmers

 Why am I interested in this?

 What journey have I taken to do this?

   * Read category theory For Programmers
   * 

# Interests 

* Practical category theory for writing APIs and writing software (modelling?)
* Type systems?
* Writing interpreters
* Writing DSLs for domains
* Invertable Parsing
* Semantics?
* Programming language implementation with category theory as semantics
* Lenses

What do I want to learn?

 * Deeper applications of category theory and writing sound APIs
 * How writing a language works

How can I help the field grow?

 * A character based answer? -> curious, self-driven, etc.?
 * Current research I've done -> I haven't formally done any research...I'll
 need to get creative here...

What have I done to show I am self driven in research?

 * Reading types and programming languages
 * category theory for programmers
 * other research papers
 * Aided as a TA in college - organized labs, taught intro to C and embedded
 programming and

What other things have I done outside of STEM to show self-drive / community
influence?

  * Volunteering at my Church
  * Involvement with ministries with college students
  * Mentoring college students
  * Travel to Europe
'')


]
