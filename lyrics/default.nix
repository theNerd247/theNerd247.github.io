let

  pkgs = (import <nixpkgs> { overlays = import (builtins.fetchGit 
    { ref = "master"; rev = "3d63e3087f69b379be0cd5efbf56c28c7bf79b69"; url = "https://github.com/theNerd247/conix.git"; }); 
    });

  conix = pkgs.conix;


  run = conix.runExtended (c: with c; module (x: x) {

    slidesPdf = expr "" ""
      (fileName: content: c.pandoc "pdf" "-t beamer" [c.pkgs.texlive.combined.scheme-small] fileName 
        ([
          (c.meta [ 
          "fontsize: 20pt"
          ])
          content
        ])
      );

      evalChords = expr "" "" 
        (title: f:  
          [ (f (mkApi false))
            #(modtxt (_: "") (pdf title (code "" (f (mkApi true)))))
          ]
        );
    });


    slide = x: (builtins.foldl' ({len, nLines, word, rendered}: c:
        if (len + builtins.stringLength word) > 38 then
          { len = if word == " " then 0 else builtins.stringLength word; 
            nLines = if nLines == 2 then 0 else nLines+1; 
            word = if word == " " then "" else word;
            rendered = rendered + "\n\n" + (if nLines == 2 then "  * * * * *\n\n" else "") + (if word == " " then "" else word);
          }
        else if c == " " then
          { len = if word == " " then len else len + 1; 
            inherit nLines; 
            isSpace = true; 
            word = " "; 
            rendered = rendered + " " + word; 
          }
        else
          { len = len + 1; inherit nLines; isSpace = false; rendered = rendered + c; }
      )
      {len = 0; nLines = 0; isSpace = false; rendered = ""; word = "";} 
      (pkgs.lib.stringToCharacters x)
    ).rendered;


    mkApi = isChords:
      { 
        onlyChords = x: if isChords then x else "";
        chordVerse = x: if isChords  then builtins.replaceStrings ["\n"] [""] x + "\n" else x;
        newSlide = if isChords then "" else "\n\n  * * * * *\n\n";

        # lineLength, n lines on slide, currentRendered text
        # 
        # c   -> (length, nLines, isSpace, rendered) 

        # (n, [])           -> (0, nill)
        # (n, (x, words))   
        #   | n > 38 && x == ' ' = LineSplit (0, words)
        #   | n > 38             = LineSplit (0, x : words)
        #   | x == ' '           = WordSep 
        #   | otherwise          = WordLetter x (n+1, words)

        # nill                                        -> (Nothing, "")
        # WordSep n (slide, slidesStr)                -> (prependChar n <$> slide, slideStr)
        # LineSplit (FilledSlide lstr rstr, slideStr) -> (Nothing, lstr <> linesplit <> slideSep <> slideStr)
        # LineSplit (OneLineSlide str, slideStr)      -> (Just $ FilledSlide str "", slideStr)0

        # WordSep
        # Word LineLength String
        # Line LineLength [Word] 
        # Slide Line (Maybe Line)
        # Slides [Slide]

        # syntax: 
        #
        # Chords ....
        # Verse ....

        # slidesFor verse:
        #
        # Multiple spaces are collapsed to one
        # Each line must be <= 38 characters long
        # Start chopping lines from the left
        # line splits are done between words
        # A new paragraph in between lines for slides
        # Only 2 lines per slide
        # Each verse starts on a set of slides

        # ' ' <> ' ' -> ' '
        # x   <> x   -> f x x
        # 
      };
in
#  { inherit slide; }
  run (c: with c; [

     (markdown "lyrics" (import ./TenThousandReasons.nix (mkApi false)))
 
     (slidesPdf "worshipLyrics" (intersperse "\n\n" [
        (evalChords "livingHope" (import ./livingHope.nix))
        (evalChords "comeToJesus" (import ./comeToJesus.nix))
       #(import ./howCanIKeepFromSinging.nix)
       # (evalChords "majesty" (import ./majesty.nix))
       #(evalChords "itIsWell" (import ./itIsWellWithMySoul.nix))
       #(evalChords "tenThousandReasons" (import ./TenThousandReasons.nix))
     ]))
 
     # (import ./heIsExaltedChords.nix)
     # (import ./standingOnThePromisesOfGodChords.nix)
# 
])
