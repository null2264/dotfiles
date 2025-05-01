# Because building from source is broken due to `sw_vers` usage
#
# REF: https://github.com/NixOS/nixpkgs/pull/306546#issuecomment-2284484876
# REF: https://github.com/jtroo/kanata/issues/1209
final: prev:

{
  kanata = final.stdenv.mkDerivation rec {
    name = "kanata";
    version = "v1.8.1";

    src = final.fetchurl {
      url = "https://github.com/jtroo/kanata/releases/download/${version}/kanata_macos_" +
        (if final.stdenv.hostPlatform.isAarch64 then "arm64" else "x86_64");
      sha256 =
        if final.stdenv.hostPlatform.isAarch64 then
          "f8704e1007cef9533bd80452e343ffc6f84f2b7747124716cdb533106ffa2e12"
        else
          "7d5abf3dbe4b9a4aca85fa7b61f821fed9b1cf4e502a641b639b54e8eb45326c";
    };

    phases = ["installPhase" "patchPhase"];
    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/kanata
      chmod +x $out/bin/kanata
    '';
  };
}
