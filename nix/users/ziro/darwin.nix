{ pkgs, pkgs-unstable, config, vars, lib, ... }:

{
  home.homeDirectory = "/Users/ziro";
  home.packages = lib.mkAfter
    [
      pkgs.casks.vscodium
    ];

  programs.browserpass = {
    enable = true;
    browsers = [ "brave" "chrome" ];  # Arc and Chrome share the same `Application Support` dir, not sure why tbh.
  };

  home.file."Library/Application Support/Floorp/native-messaging-hosts/passff.json".source = "${pkgs.passff-host}/share/passff-host/passff.json";

  # Swap CapsLock with Esc for better vi-mode experience.
  # launchd.agents.CapsEscSwap = {
  #   enable = true;
  #   config = {
  #     ProgramArguments = [
  #       "/usr/bin/hidutil"
  #       "property"
  #       "--set"
  #       ''{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029},{"HIDKeyboardModifierMappingSrc":0x700000029,"HIDKeyboardModifierMappingDst":0x700000039}]}''
  #     ];
  #     RunAtLoad = true;
  #   };
  # };

  home.sessionVariables.MOZ_LEGACY_PROFILES = 1;

  home.activation.applications = let
    env = pkgs.buildEnv {
      name = "home-applications";
      paths = config.home.packages;
      pathsToLink = "/Applications";
    };
  in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    echo "setting up ${config.home.homeDirectory}/Applications..." >&2
    rm -rf "${config.home.homeDirectory}/Applications/Nix Home Manager Apps"
    mkdir -p "${config.home.homeDirectory}/Applications/Nix Home Manager Apps"
    find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "${config.home.homeDirectory}/Applications/Nix Home Manager Apps/$app_name"
      done
  '';
}
