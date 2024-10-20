{ pkgs, config, vars, ... }:

{
  home.homeDirectory = "/Users/ziro";

  programs.browserpass = {
    enable = true;
    browsers = [ "brave" "chrome" ];  # Arc and Chrome share the same `Application Support` dir, not sure why tbh.
  };

  # Swap CapsLock with Esc for better vi-mode experience.
  launchd.agents.CapsEscSwap = {
    enable = true;
    config = {
      ProgramArguments = [
        "/usr/bin/hidutil"
        "property"
        "--set"
        ''{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029},{"HIDKeyboardModifierMappingSrc":0x700000029,"HIDKeyboardModifierMappingDst":0x700000039}]}''
      ];
      RunAtLoad = true;
    };
  };
}
