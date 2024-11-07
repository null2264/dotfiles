# REF: https://github.com/bandithedoge/nixpkgs-firefox-darwin/blob/ceaca2359e5371ccef3f92a36baf7c438b354afb/overlay.nix
final: prev:

let
  mkApp = import ../../lib/darwin/mkApp.nix;

  appFileName = "Vesktop.app";
  version = "1.5.3";
in {
  vesktop = mkApp {
    inherit (final) stdenv undmg _7zz;

    pname = "Vesktop";
    inherit appFileName version;

    src = final.fetchurl {
      url = "https://github.com/Vencord/Vesktop/releases/download/v${version}/Vesktop-${version}-universal.dmg";
      hash = "sha256-ceOUNHSOaEqCbzkM64RtUu0Yhrq4tThcXZTDd+OsEXI";
    };

    # Replace the icon with a much more low profile icon
    # REF: https://github.com/Vencord/Vesktop/pull/865
    configurePhase = ''
      cp -f ${../../../include/vesktop/icon.icns} ${appFileName}/Contents/Resources/icon.icns
    '';

    meta = with final.lib; {
      description = "An alternate client for Discord with Vencord built-in";
      homepage = "https://github.com/Vencord/Vesktop";
      license = licenses.gpl3Only;
      platforms = platforms.darwin;
      sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    };
  };
}
