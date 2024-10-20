{ pkgs, config, vars, ... }:

{
  home = {
    username = "ziro";
  };

  xdg.configFile = {
    "nix/nix.conf".text = ''
      experimental-features = nix-command flakes
    '';
  };

  home.stateVersion = "24.11";
}
