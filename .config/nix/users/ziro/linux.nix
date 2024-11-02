{ pkgs, pkgs-unstable, config, vars, ... }:

{
  home.homeDirectory = "/home/ziro";

  home.file.".floorp/native-messaging-hosts/passff.json".source = "${pkgs.passff-host}/share/passff-host/passff.json";
}
