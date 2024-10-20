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

  home.file.".floorp/native-messaging-hosts/passff.json".source = "${pkgs.passff-host}/share/passff-host/passff.json";

  home.stateVersion = "24.11";
}
