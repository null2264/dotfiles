# REF: https://github.com/bandithedoge/nixpkgs-firefox-darwin/blob/ceaca2359e5371ccef3f92a36baf7c438b354afb/overlay.nix
final: prev:

let
  mkApp = import ../../lib/darwin/mkApp.nix;
  version = "2.0.0-alpha";
in {
  heliport = mkApp {
    inherit (final) stdenv undmg _7zz;

    pname = "HeliPort";
    appFileName = "HeliPort.app";
    inherit version;

    src = final.fetchurl {
      url = "https://github.com/OpenIntelWireless/HeliPort/releases/download/v${version}/HeliPort.dmg";
      sha256 = "751e09824c3bd0662287c42d9dd3568bed9f3e7cff920e3a47b5ef67a82975db";
    };

    unpackPhase = "7zz x -snld $src || true  # assume true since it returns error even tho it's fine??";

    meta = with final.lib; {
      description = "Intel WiFi Client for itlwm";
      homepage = "https://github.com/OpenIntelWireless/HeliPort";
      license = licenses.bsd3;
      platforms = platforms.darwin;
      sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    };
  };
}
