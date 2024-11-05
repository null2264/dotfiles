# REF: https://github.com/bandithedoge/nixpkgs-firefox-darwin/blob/ceaca2359e5371ccef3f92a36baf7c438b354afb/overlay.nix
{ stdenv, undmg, _7zz, pname, version, sourceRoot ? ".", appFileName, src, meta
, nativeBuildInputs ? [ undmg _7zz ]
, unpackPhase ? "undmg $src || 7zz x -snld $src"
, installPhase ? ''
    mkdir -p $out/Applications
    cp -R ${appFileName} "$out/Applications/"
''
}:

stdenv.mkDerivation rec {
  inherit pname version;

  inherit src nativeBuildInputs;

  inherit sourceRoot;

  phases = [ "unpackPhase" "installPhase" ];
  inherit unpackPhase installPhase;

  inherit meta;
}
