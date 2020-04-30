{ stdenv
, writeTextFile
, writeScriptBin
, runtimeShell
, writeText
, pandoc
, pandoc-sidenote
, tufte-css
, pandocExtra ? ""
, useExtraStyles ? false
, useSolarizedStyles ? false
}: 

let 
  tufte-pandoc-srcs = stdenv.mkDerivation
    { name = "tufte-pandoc-srcs"; 
      buildInputs = [ tufte-css ];

      src = builtins.fetchGit
        { url = "https://github.com/jez/tufte-pandoc-css.git";
          ref = "master";
        };

      buildPhase = "";
      installPhase = ''
        mkdir -p $out
        cp ./tufte.html5 $out/tufte.html5
        cp ./*.css $out/
      '';
    };
  
  styles = 
    [ "--css=${tufte-css}/tufte.css"
      "--css=${tufte-pandoc-srcs}/pandoc.css"
    ];

  extraStyles = 
    if useExtraStyles 
      then [ "--css=${tufte-pandoc-srcs}/tufte-extra.css" ]
      else [];

  solarizedStyle = 
    if useSolarizedStyles 
      then [ "--css=${tufte-pandoc-srcs}./pandoc-solarized.css" ]
      else [];

  extraPandocFlags = 
    builtins.concatStringsSep " "
      ( styles
      ++ extraStyles
      ++ solarizedStyle
      ++ [ pandocExtra ]
      );

  tuftePandocTemplate = "${tufte-pandoc-srcs}/tufte.html5";

  makeFile = writeText "tufte-pandoc-makefile" ''
    SOURCES := $(wildcard md/*.md)
    TARGETS := $(addprefix html/,$(addsuffix .html,$(basename $(notdir $(SOURCES)))))

    .PHONY: all
    all: htmldir $(TARGETS)

    .PHONY: htmldir
    htmldir:
    	mkdir -p html

    html/%.html: md/%.md ${tuftePandocTemplate}
    	${pandoc}/bin/pandoc \
    	   --katex \
    	   --section-divs \
    	   --from markdown+tex_math_single_backslash \
    	   --filter pandoc-sidenote \
    	   --to html5+smart \
    	   --template=${tuftePandocTemplate} \
    	   --output $@ \
    	   ${extraPandocFlags} \
    	   $<
    '';
in

writeScriptBin "tufte-pandoc" ''
    #!/${runtimeShell}
    make --makefile=${makeFile} $@
''
