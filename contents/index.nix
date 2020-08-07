conix: conix.texts [ "posts" "index" ] [
''# Zettelkasten

''(conix.textOf [ "resume" ])''


# Posts

''((import ../postList.nix) true conix)''

# Drafts 

''((import ../postList.nix) false conix)''

---

Built using ''(conix.homePageLink)" v"(conix.version.text)
]
