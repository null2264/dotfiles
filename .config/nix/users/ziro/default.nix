{ pkgs, pkgs-unstable, config, vars, ... }:

{
  home = {
    username = "ziro";
    packages =
      [
        pkgs.passff-host
      ] ++ pkgs.lib.optionals (pkgs.stdenv.isDarwin) [
        pkgs.casks.vscodium
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
