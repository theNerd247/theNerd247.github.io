conix: { lib.textsd = with conix.lib; ms:
  texts ms
  // { drvs = builtins.foldl' (l: m: l ++ (m.drvs or [])) [] ms; } ;
}
