---
title: Software Engineering Team Workflow
tags:
  - git
  - team
  - work-flow
  - software-engineering
---

# Hyped up on the Rebase

Software engineers solve problems. And how we work is as important a problem
as what we work on. Over the years I've tried to solve the workflow problem
by reading what other people had to say and following their advice. Here's what
I've come up with so far:

  * If it isn't obvious: use git. It's the best thing we have for managing
    asychronous workflows. It has its quirks but what doesn't?
  * `master` is the source of truth. If code is in master it should be as close
    to the finished product as possible
  * Use feature branches. `staging`, `dev` etc. branches add more mess to the
    workflow than most people want to care about. Merging in new work should be
    simple
  * Rebase onto master frequently and squash/merge when merging in new work.
    This _was_ my favorite. It prevented large merge conflicts from occuring,
    kept my branch updated with new work, and simplified the git history. It
    made a bit of extra work along the way but it wasn't bad.

# 0, 1, Crap Ton

Most of my workflow ideas were created through working with teams no larger
than 7 people. Rebasing was hard at first but most of the people got used to
it and didn't have to struggle.

However, today I work with a team much larger than 7 people and the code
changes are enormous on a daily basis. To make matters worse, we use a mono
repo. There is no way to keep track of everything that is going on. 

When thinking about a problem I try and keep track of something in terms of how
many things I can keep track of. Are we dealing with 0 or 1 things? If we're
dealing with 2 things are they the same? Is it a list? A tree? Often I find
that if I need to work with soemthing that is greater than 1 in size then I
have to make a very important assumption: I can't count the thing I'm dealing
with - that is I have many things and should stop holding all of them in my
head.

In git workflows this means rebasing is out of the question - as a well as
trying to keep track of everything that is going on in the repo. Instead I
should only focus on 1 thing at a time and not worry about ALL the changes that
are going on in the code.

Type systems, compilers, unit testing, and the like are _critical_ for keeping
sanity whilst contributing to a large project. It makes selecting tools early
very important. Because there is some point of critical mass where switching to
a new library would be impossible - or a crap ton of work.

# Your Daily News

So how do I keep up with what's going on? I use email. GitHub sends me email
notifications to various PRs that are open. While having my morning coffee when
starting my work day the first thing I do is open my email and browse through
various PR emails. The titles are my headlines and give me an idea of what's
going on. If I find one that's interesting then I can comment or add a code
review. 
