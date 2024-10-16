{ pkgs, config, vars, ... }:

{
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
  [
    pkgs.zsh
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
  ];

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
  };

  # users.users.ziro = {
  #   name = vars.user;
  #   home = "/Users/${vars.user}";
  # };
  # home-manager.users.ziro = {
  #   home.stateVersion = "22.05";

  #   programs = {
  #     browserpass = {
  #       enable = true;
  #       browsers = [ "brave" "chrome" ];  # Arc and Chrome share the same `Application Support` dir, not sure why tbh.
  #     };
  #   };

  #   # Swap CapsLock with Esc for better vi-mode experience.
  #   launchd.agents.CapsEscSwap = {
  #     enable = true;
  #     config = {
  #       ProgramArguments = [
  #         "/usr/bin/hidutil"
  #         "property"
  #         "--set"
  #         "{\"UserKeyMapping\":[{\"HIDKeyboardModifierMappingSrc\":0x700000039,\"HIDKeyboardModifierMappingDst\":0x700000029},{\"HIDKeyboardModifierMappingSrc\":0x700000029,\"HIDKeyboardModifierMappingDst\":0x700000039}]}"
  #       ];
  #       RunAtLoad = true;
  #     };
  #   };
  # };
}
