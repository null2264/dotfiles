{ lib, config, pkgs, ... }:

let
  cfg = config.custom.heliport;
  # Figure out how to do multi-user here now that nix-darwin forced you to use root
  user = "ziro";
in {
  options = {
    custom.heliport = {
      enable = lib.mkEnableOption "Enable HeliPort";
    };
  };
  config = lib.mkIf cfg.enable {
    system.activationScripts.applications.text = pkgs.lib.mkAfter ''
      echo "moving 'HeliPort.app' from '/Applications/Nix Apps' to '/Applications'..."
      rm -rf "/Applications/HeliPort.app"
      mv "/Applications/Nix Apps/HeliPort.app" "/Applications/HeliPort.app"
    '';

    environment.systemPackages = [ pkgs.heliport ];
  };
}
