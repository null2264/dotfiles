{ pkgs, config, vars, ... }:

{
  programs.floorp = {
    enable = true;
    # REF: https://github.com/nix-community/home-manager/blob/342a1d682386d3a1d74f9555cb327f2f311dda6e/modules/programs/firefox/mkFirefoxModule.nix#L264
    package = null;  # we only want the config
    profiles.${vars.name} = {
      userChrome = builtins.replaceStrings ["/*ZI:VERTICAL-TAB-HOVER-WIDTH-IN-EM*/"] ["${builtins.toString vars.floorp.verticalTabHoverWidthInEm}em"] (builtins.readFile ../../files/floorp/userChrome.css);
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
      };
    };
  };
}
