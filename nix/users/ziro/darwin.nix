{ pkgs, pkgs-unstable, config, vars, lib, ... }:

{
  home.homeDirectory = "/Users/ziro";
  home.packages = lib.mkAfter
    [
      (pkgs.casks.vscodium.override { variation = "sonoma"; })
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
}
