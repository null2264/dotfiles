{ pkgs, config, vars, ... }:

{
  programs.zen = {
    enable = true;
    # REF: https://github.com/nix-community/home-manager/blob/342a1d682386d3a1d74f9555cb327f2f311dda6e/modules/programs/firefox/mkFirefoxModule.nix#L264
    package = null;  # we only want the config
    profiles.${config.home.username} = {
      id = 0;
      isDefault = true;
    };

    nativeMessagingHosts = [
      pkgs.passff-host
    ];
  };
}
