# Modified version of brew-nix/casks.nix
#
# REF: https://github.com/BatteredBunny/brew-nix/blob/9dfab294afea5029922bbc59a10ae487c7318d59/casks.nix
{ system, nixpkgs, brew-api, ... }:
let
  pkgs = import nixpkgs {
    inherit system;
  };

  hasBinary = cask: pkgs.lib.hasAttr "binary" (getArtifacts cask);
  hasApp = cask: pkgs.lib.hasAttr "app" (getArtifacts cask);
  hasPkg = cask: pkgs.lib.hasAttr "pkg" (getArtifacts cask);

  getName = cask: builtins.elemAt cask.name 0;

  getBinary = cask: builtins.elemAt (getArtifacts cask).binary 0;
  getApp = cask: builtins.elemAt (getArtifacts cask).app 0;
  getArtifacts = cask: pkgs.lib.mergeAttrsList cask.artifacts;

  caskToDerivation = cask: pkgs.stdenv.mkDerivation rec {
    pname = cask.token;
    version = cask.version;

    # FIXME: support variants
    src = pkgs.fetchurl {
      url = cask.url;
      sha256 = pkgs.lib.optionalString (cask.sha256 != "no_check") cask.sha256;
    };

    nativeBuildInputs = with pkgs; [
      undmg
      unzip
      gzip
      _7zz
      makeWrapper
    ] ++ pkgs.lib.optional (hasPkg cask) (with pkgs; [
      xar
      cpio
    ]);

    unpackPhase =
      if (hasPkg cask) then ''
        xar -xf $src
        for pkg in $(cat Distribution | grep -oE "#.+\.pkg" | sed -e "s/^#//" -e "s/$/\/Payload/"); do
          zcat $pkg | cpio -i
        done
      '' else if (hasApp cask) then ''
        undmg $src || 7zz x -snld $src
      '' else if (hasBinary cask) then ''
        if [ "$(file --mime-type -b "$src")" == "application/gzip" ]; then
          gunzip $src -c > ${getBinary cask}
        elif [ "$(file --mime-type -b "$src")" == "application/x-mach-binary" ]; then
          cp $src ${getBinary cask}
        fi
      '' else "";

    sourceRoot = pkgs.lib.optionalString (hasApp cask) (getApp cask);

    installPhase =
      if (hasPkg cask) then ''
        mkdir -p $out/Applications
        cp -R Applications/* $out/Applications/

        if [ -d "Resources" ]; then
          mkdir -p $out/Resources
          cp -R Resources/* $out/Resources/
        fi

        if [ -d "Library" ]; then
          mkdir -p $out/Library
          cp -R Library/* $out/Library/
        fi
      '' else if (hasApp cask) then ''
        mkdir -p "$out/Applications/${sourceRoot}"
        cp -R . "$out/Applications/${sourceRoot}"

        if [[ -e "$out/Applications/${sourceRoot}/Contents/MacOS/${getName cask}" ]]; then
          makeWrapper "$out/Applications/${sourceRoot}/Contents/MacOS/${getName cask}" $out/bin/${cask.token}
        elif [[ -e "$out/Applications/${sourceRoot}/Contents/MacOS/${pkgs.lib.removeSuffix ".app" sourceRoot}" ]]; then
          makeWrapper "$out/Applications/${sourceRoot}/Contents/MacOS/${pkgs.lib.removeSuffix ".app" sourceRoot}" $out/bin/${cask.token}
        fi
      '' else if (hasBinary cask && !hasApp cask) then ''
        mkdir -p $out/bin
        cp -R ./* $out/bin
      '' else "";

    meta = {
      homepage = cask.homepage;
      description = cask.desc;
      platforms = pkgs.lib.platforms.darwin;
      mainProgram = if (hasBinary cask && !hasApp cask) then (getBinary cask) else (cask.token);
    };
  };

  casks = builtins.fromJSON (builtins.readFile (brew-api + "/cask.json"));
in final: prev: {
  casks = builtins.listToAttrs (builtins.map
    (cask: {
      name = cask.token;
      value = caskToDerivation cask;
    })
    casks);
}
