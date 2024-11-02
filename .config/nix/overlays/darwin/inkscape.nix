# REF: https://github.com/bandithedoge/nixpkgs-firefox-darwin/blob/ceaca2359e5371ccef3f92a36baf7c438b354afb/overlay.nix
final: prev:

let
  inkscapePackage = version:
    final.stdenv.mkDerivation rec {
        pname = "Inkscape";
        inherit version;

        buildInputs = [ final.pkgs.undmg ];
        sourceRoot = ".";
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          runHook preInstall

          mkdir -p $out/Applications
          cp -r Inkscape*.app "$out/Applications/"

          runHook postInstall
        '';

        src = final.fetchurl {
          name = "Inkscape-${version}.dmg";
          url = "https://media.inkscape.org/dl/resources/file/Inkscape-${version}_${if final.stdenv.isAarch64 then "arm64" else "x86_64"}.dmg";
          sha256 = if final.stdenv.isAarch64 then "c2d89809ad8d85021e7784e72e28aee2231b0b8675ec3ede3e6fb9f1ffedb4b3" else "e3f968e131e5c3577ee21809da487eafe2a9b42370e2bf408e5811b6f965912e";
        };

      meta = with final.lib; {
        description = "Vector graphics editor";
        homepage = "https://www.inkscape.org";
        license = licenses.gpl3Plus;
        maintainers = [ maintainers.jtojnar ];
        platforms = platforms.all;
        mainProgram = "inkscape";
        longDescription = ''
          Inkscape is a feature-rich vector graphics editor that edits
          files in the W3C SVG (Scalable Vector Graphics) file format.

          If you want to import .eps files install ps2edit.
        '';
      };
    };
in {
  inkscape-bin = inkscapePackage "1.4.028868";
}
