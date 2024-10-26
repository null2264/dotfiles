{ pkgs, config, vars, ... }:

{
  programs.floorp = {
    enable = true;
    # REF: https://github.com/nix-community/home-manager/blob/342a1d682386d3a1d74f9555cb327f2f311dda6e/modules/programs/firefox/mkFirefoxModule.nix#L264
    package = null;  # we only want the config
    profiles.${vars.name} = {
      userChrome = builtins.readFile ../../files/floorp/userChrome.css;
      settings = {
        "browser.toolbars.bookmarks.visibility" = "newtab";
        "floorp.browser.sidebar.is.displayed" = false;
        "floorp.browser.tabbar.settings" = 2;
        "floorp.browser.tabs.verticaltab" = true;
        "floorp.browser.tabs.verticaltab.width" = 208;
        "floorp.verticaltab.hover.enabled" = true;
        "floorp.tabbar.style" = 2;
      };
    };
  };
}
