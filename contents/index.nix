conix: conix.texts [ "posts" "index" ] [
''# Thoughts of a Functional Programmer

<div class="about" >
* [GitHub](''(conix.at [ "portfolio" "gitHubLink"]) '')
* [LinkedIn](''(conix.at [ "portfolio" "linkedInLink"]) '')
* [Resume](./resume.html)
</div>

# Posts

''((import ../postList.nix) true conix)''

# Drafts 

''((import ../postList.nix) false conix)''

---

Built using ''(conix.homePageLink)" v"(conix.version.text)
]
