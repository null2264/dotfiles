{ pkgs, pkgs-unstable, spicePkgs, config, vars, common, inputs, ... }:

let
  libFixup = import ../../lib/darwin/libFixup.nix;
  nix-srisum = pkgs.writeShellScriptBin "nix-srisum" ''
    nix-hash --to-sri --type sha256 $(nix-prefetch-url ''$1)
  '';
  nix-srisum-unzip = pkgs.writeShellScriptBin "nix-srisum-unzip" ''
    FILES_TO_DOWNLOAD=($@)
    mkdir -p /tmp/nix-srisum-unzip-files
    for i in "''${FILES_TO_DOWNLOAD[@]}"; do
      filename="''$(uuidgen):archive.zip"
      wget -q -O /tmp/nix-srisum-unzip-files/$filename ''$i

      dirname="$(uuidgen):extract"
      mkdir -p /tmp/nix-srisum-unzip-files/$dirname
      unzip -qq -d /tmp/nix-srisum-unzip-files/$dirname /tmp/nix-srisum-unzip-files/$filename

      hash=$(nix-hash --to-sri --type sha256 $(nix-hash --type sha256 /tmp/nix-srisum-unzip-files/$dirname))
      echo "''$hash - ''$i"
    done
  '';
in {
  # I don't want to risk breaking my hackintosh setup in case Apple decided to
  # turn on auto install by default.
  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

  # NOTE: List packages installed in system profile. To search by name, run:
  # `nix-env -qaP | grep wget`
  environment.systemPackages =
    common.packages ++ [
      pkgs.git
      pkgs.vim
      pkgs.neovim
      pkgs.htop-vim
      pkgs.wget
      pkgs.eza
      pkgs.coreutils-full
      pkgs.rclone
      pkgs.casks.iterm2
      pkgs.nmap
      pkgs.cargo
      pkgs.android-tools
      pkgs.duti
      pkgs.undmg
      pkgs.mkalias
      pkgs.jq
      nix-srisum
      nix-srisum-unzip

      # lan-mouse deps
      # FIXME: Find a better way to link <packages>/lib to /usr/local/opt/<lib>/lib
      # (libFixup { package = pkgs.libadwaita; inherit (pkgs) runCommandLocal; name = "libadwaita"; })
      # (libFixup { package = pkgs.gtk4; inherit (pkgs) runCommandLocal; name = "gtk4"; })
      # (libFixup { package = pkgs.pango; inherit (pkgs) runCommandLocal; name = "pango"; })
      # (libFixup { package = pkgs.harfbuzz; inherit (pkgs) runCommandLocal; name = "harfbuzz"; })
      # (libFixup { package = pkgs.gdk-pixbuf; inherit (pkgs) runCommandLocal; name = "gdk-pixbuf"; })
      # (libFixup { package = pkgs.cairo; inherit (pkgs) runCommandLocal; name = "cairo"; })
      # (libFixup { package = pkgs.graphene; inherit (pkgs) runCommandLocal; name = "graphene"; })
      # (libFixup { package = pkgs.glib; inherit (pkgs) runCommandLocal; name = "glib"; })
      # (libFixup { package = pkgs.gettext; inherit (pkgs) runCommandLocal; name = "gettext"; })

      pkgs.pinentry_mac  # for GPG

      common.custom.python
      #(pkgs.poetry.override { python3 = common.custom.python; })
      pkgs.wimlib
      pkgs.google-cloud-sdk
      (pkgs.yt-dlp.override { withAlias = true; })

      pkgs.iina
      # pkgs.floorp-bin
      pkgs.zen-bin
      common.custom.inkscape
      pkgs.casks.zotero
      # pkgs.casks.lulu  # Doesn't work, it needs to be installed on /Applications/
      # pkgs.heliport  # FIXME: https://github.com/matthewbauer/undmg/issues/2

      pkgs.lf
      pkgs.yazi  # lf replacement, need further testing

      pkgs.kanata
    ];
  environment.extraSetup = ''
    ln -sv ${pkgs.path} $out/nixpkgs
  '';

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings.experimental-features = "nix-command flakes";  # stopping nix from crying about using experimental features flakes and nix-command
    nixPath = [ "nixpkgs=/run/current-system/sw/nixpkgs" ];
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enableCompletion = false;  # causing "insecure directories and files" error if user doesn't have configured zsh

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      shuffle
    ];
  };

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
    activationScripts.applications.text = let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in pkgs.lib.mkForce ''
      echo "setting up /Applications..." >&2
      rm -rf "/Applications/Nix Apps"
      mkdir -p "/Applications/Nix Apps"
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
    '';
  };
}
