{ package, runCommandLocal, name }:

runCommandLocal "${name}-symlink" {}
  ''
  dest="/usr/local/opt/${name}"

  mkdir -p $dest

  ln -sf "${package.out}/lib/" "$dest" && mkdir -p "$out" && touch "$out/${name}-done"
  ''
