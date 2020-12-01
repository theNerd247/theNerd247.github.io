(import <nixpkgs>
{ overlays = import (builtins.fetchGit
    { url = "https://github.com/theNerd247/conix.git";
      ref = "master";
      rev = "af94b448d64d918de165ba884f3ae6165ef8d0e8";
    });
}).conix.run 

(conix: with conix; html "obsidian" ''
Dear Hiring Manager,

I am writing with an interest in learning more about the Haskell team at
Obsidian Systems and any opportunities to join. 

I have been programming in Haskell and Nix for the last 5 years in various
projects ranging from web applications to a custom programming language for
writing technical documents. I have a B.S in Mechatronics Engineering
(Robotics) and am continuously pushing myself to grow by studying various
branches of mathematics (similar to the interests noted by Elliot Cameron on
his GitHub profile - I'm assuming he is still a member of the team). Recently I
completed an internship with Awake Security as a Haskell + Nix developer where
I was mentored by Gabriel Gonzalez - a prominent member of the Haskell
community.

Among my technical skills I strive to be a seamless collaborator with teams
that I work with. I take the initiative to solve problems that others may not
notice while maintaining healthy communication channels with other members of
the team and business. I value strong peer-mentoring relationships as well as
having fun while I work and building relationships with other team members
beyond just day to day tasks.

If possible I would like to have further discussion regarding my qualifications
and whether I would be a good fit for the team. I have also attached my resume.

Sincerely and Happy Thanksgiving,

Noah Harvey
''
)

# Goal: 
#   
#   * Invite for a conversation for:
#     
#     * Learning more about Obsidian
#     * Whether I would be a good fit for the team
#   * See if any opportunities were available to join the team
#   
# What makes me stand out:
#   
#   * Technical Skill
# 
#     * Haskell + Nix (personal projects, professional experience at Awake)
#     * Interest in applied mathematics such as Category Theory, and Type Theory
# 
#   * Soft Skills
#     
#     * self-driven
#     * Inventive 
#     * Team player / teachable
