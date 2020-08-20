conix: { index = with conix.lib; postHtmlFile "index" "--css ./static/homepage.css" (texts [
''# Thoughts of a Functional Programmer

<div class="about" >

![](./static/profile.jpg)

* [GitHub](${conix.resume.gitHubLink})
* [LinkedIn](${conix.resume.linkedInLink})
* [Resume](resume/resume.html)
</div>

# Posts

''(postList false conix.posts)''

# Drafts 

''(postList true conix.posts)''

---

Built using ${conix.lib.homePageLink} v${conix.lib.version.text}

'']);}
