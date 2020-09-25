[ (conix: { 
    resume.drv = with conix.lib; dir "resume" [ (dir "resume"
      [ 
        (htmlFile "resume" "--css ./static/latex.css --css ./static/main.css --metadata pagetitle=\"Resume - Noah Harvey\""
          (markdownFile "resume" conix.resume)
        )

        (pandoc "docx" [] "resume" ""  
          (htmlFile "resume" "--css ./static/latex.css --css ./static/main.css --metadata pagetitle=\"Resume - Noah Harvey\""
            (markdownFile "resume" conix.resume)
          )
        )
        ./static
      ]
    )];
  })
  (import ./data.nix)
  (import ./resume.nix)
  (c: { drv = c.resume.drv; })
]
