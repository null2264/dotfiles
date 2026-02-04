{ pkgs, pkgs-unstable, config, vars, ... }:

let
  username = "ziro";
  settings-ff-common = {
    "browser.toolbars.bookmarks.visibility" = "newtab";
    "network.dns.disableIPv6" = true;
    "sidebar.position_start" = false;
    "signon.management.page.breach-alerts.enabled" = false;
    "signon.rememberSignons" = false;
    "extensions.autoDisableScopes" = 0;  # Auto enable extensions
  };
  settings-ff-zen = settings-ff-common // {
    "zen.view.compact" = true;
  };
  extensions-ff-common = with pkgs.nur.repos.rycee.firefox-addons; [
    # AdBlocker
    ublock-origin

    # YouTube
    enhancer-for-youtube
    sponsorblock
    dearrow

    # Other
    passff
    tampermonkey
    indie-wiki-buddy
    facebook-container
  ];
in {
  home = {
    inherit username;
    packages =
      [
      ];
  };

  programs.zen.profiles.${username} = {
    settings = settings-ff-zen;
    extensions.packages = extensions-ff-common;
  };

  xdg.configFile = {
    "nix/nix.conf".text =
      ''
        experimental-features = nix-command flakes
      '';
  };

  home.stateVersion = "25.11";
}
