path: start: end: conix:

let
  pkgs = import ./pkgs.nix;

  splitLines = text:
    let
      splitLines_ = {lines, line}: ix:
        let 
          char = builtins.substring ix 1 text;
          newLine = if line == null then char else "${line}${char}";
        in
          if char == "\n"
            then { lines = lines ++ [ line ]; line = null; }
            else { lines = lines; line = newLine; };

      linesAndLine = builtins.foldl'
        splitLines_ 
        { lines = []; line = null; } 
        (pkgs.lib.lists.range 0 ((builtins.stringLength text) - 1));

      lastLine = if linesAndLine.line == null then [] else [linesAndLine.line];
    in
      linesAndLine.lines ++ lastLine;

  extractLines = text:
    (builtins.concatStringsSep "\n"
      (pkgs.lib.lists.sublist 
        (start - 1) 
        (end - start + 1)
        (splitLines text)
      )
    );
in
  conix.mapVal 
    (t: 
      ''
      ```
      ${extractLines t}
      ```
      ''
    ) 
    (conix.at path)
