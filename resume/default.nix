[ 
  (conix: { resume.drv = with conix.lib; dir "resume"
    [ (htmlFile "resume" "--css ./static/latex.css --css ./static/main.css"
        (markdownFile "resume" conix.resume)
      )
      ./static
    ];
  })
  (import ./resume.nix)
  (import ./data.nix)
  (c: { drv = c.resume.drv; })
]
