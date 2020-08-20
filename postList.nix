conix: { lib.postList = with conix.lib; draftStatus: posts:
  foldAttrsIxCond (s: s ? title)
    (post: path: text (
      if (post ? draft) && post.draft == draftStatus then
        ''
        * [${post.title}](./${builtins.elemAt path ((builtins.length path) - 1)}.html)
        ''
      else 
        ""
    ))
    (postAttrs: foldModules (builtins.attrValues postAttrs))
    posts;
}
