{ stdenv
, writeTextFile
, writeScriptBin
, runtimeShell
, writeText
, pandoc
, pandoc-sidenote
, tufte-pandoc-srcs
, tufte-css
, pandocExtra ? ""
, useExtraStyles ? false
, useSolarizedStyles ? false
}: 

let 
  styles = 
    [ "--css=./tufte.min.css"
      "--css=./pandoc.css"
    ];

  extraStyles = 
    if useExtraStyles 
      then [ "--css=./tufte-extra.css" ]
      else [];

  solarizedStyle = 
    if useSolarizedStyles 
      then [ "--css=./pandoc-solarized.css" ]
      else [];

  extraPandocFlags = 
    builtins.concatStringsSep " "
      [ pandocExtra ];
#      ( styles
#      ++ extraStyles
#      ++ solarizedStyle
#      ++ [ pandocExtra ]
#      );

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
    	   --to html5+smart \
    	   --output $@ \
    	   ${extraPandocFlags} \
    	   $<
    '';
in

writeScriptBin "tufte-pandoc" ''
    #!/${runtimeShell}
    make --makefile=${makeFile} $@
''
