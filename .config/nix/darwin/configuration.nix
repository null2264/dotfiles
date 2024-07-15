{ pkgs, vars, ... }:

{
  # I don't want to risk breaking my hackintosh setup in case Apple decided to
  # turn on auto install by default.
  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

  # NOTE: List packages installed in system profile. To search by name, run:
  # `nix-env -qaP | grep wget`
  environment.systemPackages = [
    pkgs.zsh
    pkgs.git
    pkgs.vim
    pkgs.neovim
    pkgs.pass
    pkgs.passExtensions.pass-otp
    pkgs.pinentry_mac
    pkgs.gnupg
    pkgs.htop-vim
    (pkgs.python312Full.withPackages (py: [
      py.pip
      py.tkinter
    ]))
    # FIXME: Build failed, dnspython pytest keep returning FAILED caused by timeout. Maybe find a way to bypass check for them
    # (pkgs.poetry.override { python3 = python; })
    pkgs.fastfetch
    pkgs.eza
    pkgs.lf
    pkgs.wimlib
    pkgs.google-cloud-sdk
    pkgs.nmap
    pkgs.cargo
    pkgs.android-tools
    # pkgs.browserpass
    pkgs.coreutils-full
    ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = vars.rev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system = {
    stateVersion = 4;
  };

  users.users.ziro = {
    name = "ziro";
    home = "/Users/ziro";
  };
  home-manager.users.ziro = {
    home.stateVersion = "22.05";
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
# vim:set ts=2 sw=2 et: