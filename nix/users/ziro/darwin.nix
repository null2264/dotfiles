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

  home.sessionVariables = {
    MOZ_LEGACY_PROFILES = 1;
    MOZ_ALLOW_DOWNGRADE = 1;
  };

  # Pass sessionVariables to GUI apps with launchctl
  #
  # REF: https://github.com/nix-community/home-manager/pull/5801/commits/dbe54a48a0bc9942289f6a5d8a751ed3be065c81
  launchd.agents.launchctl-setenv = let
    launchctl-setenv = pkgs.writeShellScriptBin "launchctl-setenv"
      (lib.concatStringsSep "\n" (lib.mapAttrsToList
        (name: val: "/bin/launchctl setenv ${name} ${toString val}")
        config.home.sessionVariables));
  in {
    enable = true;
    config = {
      ProgramArguments = [ "${launchctl-setenv}/bin/launchctl-setenv" ];
      KeepAlive.SuccessfulExit = false;
      RunAtLoad = true;
    };
  };

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
      while read -r src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "${config.home.homeDirectory}/Applications/Nix Home Manager Apps/$app_name"
      done
  '';
}
