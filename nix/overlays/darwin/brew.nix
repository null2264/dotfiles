# Modified version of brew-nix/casks.nix to support macOS version variations
#
# REF: https://github.com/BatteredBunny/brew-nix/blob/928e5382d927727666bcbbd27240e73eeb269b4a/casks.nix
{
  system,
  mac-version ? "ventura",
  nixpkgs,
  brew-api,
  ...
}:
let
  pkgs = import nixpkgs {
    inherit system;
  };
  lib = pkgs.lib;

  getName = cask: builtins.elemAt cask.name 0;
  getBinary = artifacts: builtins.elemAt artifacts.binary 0;
  getApp = artifacts: builtins.elemAt artifacts.app 0;

  caskToDerivation =
    cask:
    let
      artifacts = lib.mergeAttrsList cask.artifacts;
      isBinary = lib.hasAttr "binary" artifacts;
      isApp = lib.hasAttr "app" artifacts;
      isPkg = lib.hasAttr "pkg" artifacts;
      url = (cask.variations.${mac-version} or cask).url;
      hash = (cask.variations.${mac-version} or cask).sha256;
    in
    pkgs.stdenv.mkDerivation rec {
      pname = cask.token;
      inherit (cask) version;

      src = pkgs.fetchurl {
        inherit url;
        sha256 = pkgs.lib.optionalString (hash != "no_check") hash;
      };

      nativeBuildInputs =
        with pkgs;
        [
          undmg
          unzip
          gzip
          _7zz
          makeWrapper
        ]
        ++ pkgs.lib.optional isPkg (
          with pkgs;
          [
            xar
            cpio
          ]
        );

      unpackPhase =
        if isPkg then ''
          xar -xf $src
          for pkg in $(cat Distribution | grep -oE "#.+\.pkg" | sed -e "s/^#//" -e "s/$/\/Payload/"); do
            zcat $pkg | cpio -i
          done
        '' else if isApp then ''
          undmg $src || 7zz x -snld $src
        '' else if isBinary then ''
          if [ "$(file --mime-type -b "$src")" == "application/gzip" ]; then
            gunzip $src -c > ${getBinary artifacts}
          elif [ "$(file --mime-type -b "$src")" == "application/x-mach-binary" ]; then
            cp $src ${getBinary artifacts}
          fi
        '' else "";

      sourceRoot = pkgs.lib.optionalString isApp (getApp artifacts);

      # Patching shebangs invalidates code signing
      dontPatchShebangs = true;

      installPhase =
        if isPkg then ''
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
        '' else if isApp then ''
          mkdir -p "$out/Applications/${sourceRoot}"
          cp -R . "$out/Applications/${sourceRoot}"

          if [[ -e "$out/Applications/${sourceRoot}/Contents/MacOS/${getName cask}" ]]; then
            makeWrapper "$out/Applications/${sourceRoot}/Contents/MacOS/${getName cask}" $out/bin/${cask.token}
          elif [[ -e "$out/Applications/${sourceRoot}/Contents/MacOS/${pkgs.lib.removeSuffix ".app" sourceRoot}" ]]; then
            makeWrapper "$out/Applications/${sourceRoot}/Contents/MacOS/${pkgs.lib.removeSuffix ".app" sourceRoot}" $out/bin/${cask.token}
          fi
        '' else if (isBinary && !isApp) then ''
          mkdir -p $out/bin
          cp -R ./* $out/bin
        '' else "";

      meta = {
        inherit (cask) homepage;
        description = cask.desc;
        platforms = pkgs.lib.platforms.darwin;
        mainProgram = if (isBinary && !isApp) then (getBinary artifacts) else (cask.token);
      };
    };

  casks = lib.importJSON (brew-api + "/cask.json");
in final: prev: {
  casks = lib.listToAttrs (
    builtins.map (cask: {
      name = cask.token;
      value = caskToDerivation cask;
    }) casks
  );
}
