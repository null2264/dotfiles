# REF: https://github.com/bandithedoge/nixpkgs-firefox-darwin/blob/ceaca2359e5371ccef3f92a36baf7c438b354afb/overlay.nix
{ stdenv, undmg, pname, version, sourceRoot ? ".", appFileName, src, meta, nativeBuildInputs ? [ undmg ] }:

stdenv.mkDerivation rec {
  inherit pname version;

  inherit src nativeBuildInputs;

  inherit sourceRoot;

  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p $out/Applications
    cp -R ${appFileName} "$out/Applications/"
  '';

  inherit meta;
}
