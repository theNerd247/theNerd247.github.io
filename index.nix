c: with c; html "index" [

  (meta [ 
    [''
      css: 
        - ''(pathOf ./static/homepage.css)
     "\n  - " (pathOf ./static/zettelkasten.css)
   ]
        
    "pagetitle: Noah Harvey"
  ])''


# Noah Harvey

<div class="about" >

![](''(pathOf ./static/profile.jpg)'')

* [GitHub](''(r data.resume.gitHubLink)'')
* [LinkedIn](''(r data.resume.linkedInLink)'')
* [Resume](resume/resume.html)
</div>

# Sermon Notes

''(r (list data.sermons.links))
''

---

Built using [conix](''(r conix.homepageUrl)'') v''(r conix.version.text)

]
