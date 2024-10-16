{ pkgs, config, vars, common, ... }:

{
  # I don't want to risk breaking my hackintosh setup in case Apple decided to
  # turn on auto install by default.
  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

  # NOTE: List packages installed in system profile. To search by name, run:
  # `nix-env -qaP | grep wget`
  environment.systemPackages =
  let
    python = (pkgs.python312Full.withPackages (py: [
      py.pip
      py.tkinter
      py.dnspython
    ]));
  in
  common.packages ++ [
    pkgs.git
    pkgs.vim
    pkgs.neovim
    pkgs.pass
    pkgs.passExtensions.pass-otp
    pkgs.gnupg
    pkgs.htop-vim
    python
    (pkgs.inkscape.override { python3 = python; })
    #(pkgs.poetry.override { python3 = python; })
    pkgs.fastfetch
    pkgs.eza
    pkgs.lf
    pkgs.wimlib
    pkgs.google-cloud-sdk
    pkgs.nmap
    pkgs.cargo
    pkgs.android-tools
    pkgs.coreutils-full
    pkgs.rclone
    (pkgs.yt-dlp.override { withAlias = true; })
    pkgs.zoxide
  # >> For macOS only
  ] ++ pkgs.lib.optionals (pkgs.stdenv.isDarwin) [
    pkgs.duti
    pkgs.pinentry_mac
    pkgs.iina
  ];
  # << For macOS only

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  #nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  #programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = vars.rev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system = {
    stateVersion = 4;
    # Nix-darwin does not link installed applications to the user environment. This means apps will not show up
    # in spotlight, and when launched through the dock they come with a terminal window. This is a workaround.
    # Upstream issue: https://github.com/LnL7/nix-darwin/issues/214
    # Original code: https://github.com/IvarWithoutBones/dotfiles/commit/0b3faad8bd1d0e1af6103caf59b206666ab742f4
    activationScripts.applications.text = pkgs.lib.mkForce ''
      echo "setting up ~/Applications..." >&2
      applications="/Applications"
      nix_apps="$applications/Nix Apps"

      # Delete the directory to remove old links
      rm -rf "$nix_apps"
      mkdir -p "$nix_apps"
      find ${config.system.build.applications}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read src; do
            ln -s "$src" "$nix_apps"

            # >> Original linking script - I don't use Spotlight
            # Spotlight does not recognize symlinks, it will ignore directory we link to the applications folder.
            # It does understand MacOS aliases though, a unique filesystem feature. Sadly they cannot be created
            # from bash (as far as I know), so we use the oh-so-great Apple Script instead.
            # /usr/bin/osascript -e "
            #     set fileToAlias to POSIX file \"$src\" 
            #     set applicationsFolder to POSIX file \"$nix_apps\"
            #     tell application \"Finder\"
            #         make alias file to fileToAlias at applicationsFolder
            #         # This renames the alias; 'mpv.app alias' -> 'mpv.app'
            #         set name of result to \"$(rev <<< "$src" | cut -d'/' -f1 | rev)\"
            #     end tell
            # " 1>/dev/null
            # << Original linking script
          done
    '';
  };

  users.users.ziro = {
    name = vars.user;
    home = "/Users/${vars.user}";
  };
  home-manager.users.ziro = {
    home.stateVersion = "22.05";

    programs = {
      browserpass = {
        enable = true;
        browsers = [ "brave" "chrome" ];  # Arc and Chrome share the same `Application Support` dir, not sure why tbh.
      };
    };

    # Swap CapsLock with Esc for better vi-mode experience.
    launchd.agents.CapsEscSwap = {
      enable = true;
      config = {
        ProgramArguments = [
          "/usr/bin/hidutil"
          "property"
          "--set"
          "{\"UserKeyMapping\":[{\"HIDKeyboardModifierMappingSrc\":0x700000039,\"HIDKeyboardModifierMappingDst\":0x700000029},{\"HIDKeyboardModifierMappingSrc\":0x700000029,\"HIDKeyboardModifierMappingDst\":0x700000039}]}"
        ];
        RunAtLoad = true;
      };
    };
  };
}
