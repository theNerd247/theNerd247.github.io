pkgs: name: paths:
pkgs.runCommand name { passAsFile = [ "paths" ]; inherit paths;}
  ''
  mkdir -p $out
  for i in $(cat $pathsPath); do
    if [[ -d $i ]]; then
      cp -r $i/* $out/
    else
      cp $i $out/$(stripHash $i)
    fi
  done
  ''
