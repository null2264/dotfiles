{ pkgs, config, vars, ... }:

{
  home = {
    username = "ziro";
    packages =
      [
        pkgs.passff-host
      ];
  };

  xdg.configFile = {
    "nix/nix.conf".text =
      ''
        experimental-features = nix-command flakes
      '';
  };

  home.stateVersion = "24.11";
}
