# REF: https://github.com/bandithedoge/nixpkgs-firefox-darwin/blob/ceaca2359e5371ccef3f92a36baf7c438b354afb/overlay.nix
final: prev:

let
  mkApp = import ../../lib/darwin/mkApp.nix;
  version = "1.5.3";
in {
  vesktop = mkApp {
    inherit (final) stdenv undmg _7zz;

    pname = "Vesktop";
    appFileName = "Vesktop*.app";
    inherit version;

    src = final.fetchurl {
      url = "https://github.com/Vencord/Vesktop/releases/download/v${version}/Vesktop-${version}-universal.dmg";
      hash = "sha256-ceOUNHSOaEqCbzkM64RtUu0Yhrq4tThcXZTDd+OsEXI";
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
