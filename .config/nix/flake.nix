{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: let
      python = pkgs.python310Full.override {
        # FIXME: Build failed, maybe override postInstall instead?
        #enableFramework = true;
      };
    in
    {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
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
        python
        # FIXME: Build failed, dnspython pytest keep returning FAILED caused by timeout. Maybe find a way to bypass check for them
        # (pkgs.poetry.override { python3 = python; })
        pkgs.python310Packages.pip
        pkgs.python310Packages.tkinter
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
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "x86_64-darwin";
    };
  in
  {
    # TODO: Split configurations

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#ThiccBook-Pro
    darwinConfigurations."ThiccBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."ThiccBook-Pro".pkgs;
  };
}
# vim:set ts=2 sw=2 et:
