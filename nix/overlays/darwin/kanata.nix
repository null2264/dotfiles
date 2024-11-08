# Because building from source is broken due to `sw_vers` usage
#
# REF: https://github.com/NixOS/nixpkgs/pull/306546#issuecomment-2284484876
# REF: https://github.com/jtroo/kanata/issues/1209
final: prev:

{
  kanata = final.stdenv.mkDerivation rec {
    name = "kanata";
    version = "v1.7.0";

    src = final.fetchurl {
      url = "https://github.com/jtroo/kanata/releases/download/${version}/kanata_macos_" +
        (if final.stdenv.hostPlatform.isAarch64 then "arm64" else "x86_64");
      sha256 =
        if final.stdenv.hostPlatform.isAarch64 then
          "83ad80fbaf8c7b0ec0e17052a02ca0b3057cbbeaf8a023a61541f1514a936b43"
        else
          "e3f0d99e512a84c5cae1f63e71c07ecdbff66dc89b053aba0abb4f9dee0cadc0";
    };

    phases = ["installPhase" "patchPhase"];
    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/kanata
      chmod +x $out/bin/kanata
    '';
  };
}
