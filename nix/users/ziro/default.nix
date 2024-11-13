{ pkgs, pkgs-unstable, config, vars, ... }:

let
  username = "ziro";
  userChrome-ff-floorp = builtins.replaceStrings ["/*ZI:*/18em/*:VERTICAL-TAB-HOVER-WIDTH-IN-EM*/"] ["${builtins.toString vars.floorp.verticalTabHoverWidthInEm}em"] (builtins.readFile ../../../include/floorp/ziro-userChrome.css);
  settings-ff-common = {
    "browser.toolbars.bookmarks.visibility" = "newtab";
    "network.dns.disableIPv6" = true;
    "sidebar.position_start" = false;
    "signon.management.page.breach-alerts.enabled" = false;
    "signon.rememberSignons" = false;
    "extensions.autoDisableScopes" = 0;  # Auto enable extensions
  };
  settings-ff-floorp = settings-ff-common // {
    "floorp.browser.sidebar.is.displayed" = false;
    "floorp.browser.tabbar.settings" = 2;
    "floorp.browser.tabs.verticaltab" = true;
    "floorp.verticaltab.hover.enabled" = true;
    "floorp.tabbar.style" = 2;
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

  programs.floorp.profiles.${username} = {
    userChrome = userChrome-ff-floorp;
    settings = settings-ff-floorp;
    extensions = extensions-ff-common;
  };
  programs.floorp.profiles.null = {
    id = 1;
    userChrome = userChrome-ff-floorp;
    settings = settings-ff-floorp;
    extensions = extensions-ff-common;
  };

  programs.zen.profiles.${username} = {
    settings = settings-ff-common;
    extensions = extensions-ff-common;
  };

  xdg.configFile = {
    "nix/nix.conf".text =
      ''
        experimental-features = nix-command flakes
      '';
  };

  home.stateVersion = "24.11";
}
