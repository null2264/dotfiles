{ pkgs, pkgs-unstable, config, vars, ... }:

let
  username = "ziro";
  userChrome = builtins.replaceStrings ["/*ZI:VERTICAL-TAB-HOVER-WIDTH-IN-EM*/"] ["${builtins.toString vars.floorp.verticalTabHoverWidthInEm}em"] (builtins.readFile ../../files/floorp/ziro-userChrome.css);
  settings = {
    "browser.toolbars.bookmarks.visibility" = "newtab";
    "floorp.browser.sidebar.is.displayed" = false;
    "floorp.browser.tabbar.settings" = 2;
    "floorp.browser.tabs.verticaltab" = true;
    "floorp.verticaltab.hover.enabled" = true;
    "floorp.tabbar.style" = 2;
    "network.dns.disableIPv6" = true;
    "sidebar.position_start" = false;
    "signon.management.page.breach-alerts.enabled" = false;
    "signon.rememberSignons" = false;
    "extensions.autoDisableScopes" = 0;  # Auto enable extensions
  };
  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    ublock-origin
  ];
in {
  home = {
    inherit username;
    packages =
      [
        pkgs.passff-host
      ];
  };

  programs.floorp.profiles.${username} = {
    inherit userChrome settings extensions;
  };
  programs.floorp.profiles.null = {
    id = 1;
    inherit userChrome settings extensions;
  };

  xdg.configFile = {
    "nix/nix.conf".text =
      ''
        experimental-features = nix-command flakes
      '';
  };

  home.stateVersion = "24.11";
}
