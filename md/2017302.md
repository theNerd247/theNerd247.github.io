---
title: Travis Nix Deploy with GHPages
tags:
  - nix
  - travis-ci
  - programming
---

To deploy with nix:

  1. Create a `default.nix`
  1. add a `.travis.yaml` to the repo with

    ```
    language: nix

    branches:
      only:
        - master

    deploy:
      provider: pages:git
      edge: true
      local_dir: ./result
      target_branch: gh-pages
      # Set in the settings page of your repository, as a secure variable
      token: $GITHUB_TOKEN  
    ```
  1. make sure to set the `GITHUB_TOKEN` as an environment variable to the
     value on [you github access tokens](https://github.com/settings/tokens)
  1. Push to master and wait for a successful deploy
  1. Make sure to set the GH Pages in your repo to use the `gh-pages` branch.
