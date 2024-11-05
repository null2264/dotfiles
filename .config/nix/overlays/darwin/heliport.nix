# REF: https://github.com/bandithedoge/nixpkgs-firefox-darwin/blob/ceaca2359e5371ccef3f92a36baf7c438b354afb/overlay.nix
final: prev:

let
  mkApp = import ../../lib/darwin/mkApp.nix;
  version = "1.5.0";
in {
  heliport = mkApp {
    inherit (final) stdenv undmg;

    pname = "HeliPort";
    appFileName = "HeliPort.app";
    inherit version;

    src = final.fetchurl {
      url = "https://github.com/OpenIntelWireless/HeliPort/releases/download/v${version}/HeliPort.dmg";
      sha256 = "49cbe7abea742a3c662a836f14c05b79b3e6e6577c897b57101f5bd0a086eec8";
    };

    meta = with final.lib; {
      description = "Intel WiFi Client for itlwm";
      homepage = "https://github.com/OpenIntelWireless/HeliPort";
      license = licenses.bsd3;
      platforms = platforms.darwin;
      sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    };
  };
}
