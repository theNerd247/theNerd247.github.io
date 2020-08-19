conix: { index = conix.lib.texts [
''# Thoughts of a Functional Programmer

<div class="about" >
* [GitHub](${conix.resume.gitHubLink})
* [LinkedIn](${conix.resume.linkedInLink})
* [Resume](./resume.html)
</div>

# Posts

''#((import ../postList.nix) true conix)''
''

# Drafts 

''#((import ../postList.nix) false conix)''
''

---

Built using ${conix.homePageLink} v${conix.version.text}

''];}
