# REF: https://github.com/bandithedoge/nixpkgs-firefox-darwin/blob/ceaca2359e5371ccef3f92a36baf7c438b354afb/overlay.nix
final: prev:

let
  mkApp = import ../../lib/darwin/mkApp.nix;
  version = "1.5.2";
in {
  vesktop = mkApp {
    inherit (final) stdenv undmg;

    pname = "Vesktop";
    appFileName = "Vesktop*.app";
    inherit version;

    nativeBuildInputs = [ final._7zz ];

    src = final.fetchurl {
      url = "https://github.com/Vencord/Vesktop/releases/download/v${version}/Vesktop-${version}.dmg";
      hash = "sha256-/u2G5v98+FAIfg7UMq5vUFmYO2Tj5ZiAaLrdqUdOMAo";
    };

    meta = with final.lib; {
      description = "An alternate client for Discord with Vencord built-in";
      homepage = "https://github.com/Vencord/Vesktop";
      license = licenses.gpl3Only;
      platforms = platforms.darwin;
      sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    };
  };
}
