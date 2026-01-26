{ inputs, nixpkgs-stable, nixpkgs-unstable, nur, brew-nix, home-manager, vars, ... }:

let
  mkSystem = import ../lib/mkSystem.nix;
  mkBrew =
    system:
    final: _: {
      casks = brew-nix.packages.${system};
    };

  defaultModules = [
    ../modules/home-manager/__programs/zen.nix
  ];
in
{
  # Host list
  # Build with: `home-manager build --flake .#<user>@<host>`
  # e.g. `home-manager build --flake .#"ziro@ThiccBook-Pro"`
  # Switch to current build: `home-manager switch --flake .#<user>@<host>`
  #
  # If you're feeling lucky `home-manager build --flake .` or
  # `home-manager switch --flake .` should be enough, since home-manager will
  # search the correct <user>@<host> on its own.
  #
  # You may need to run `scutil --set HostName <host>` if home-manager can't
  # find your <user>@<host>.

  "ziro@ThiccBook-Pro" =
    let
      system = "x86_64-darwin";
      inherit (
        mkSystem {
          arch = system;
          stable = nixpkgs-stable;
          unstable = nixpkgs-unstable;
          extraOverlays = [
            inputs.firefox-darwin.overlay
            (mkBrew system)
            (import ../overlays/darwin/kanata.nix)
          ];
          nur = nur;
        }
      ) pkgs pkgs-unstable;
      vars.floorp.verticalTabHoverWidthInEm = 28;
    in
    home-manager.lib.homeManagerConfiguration {
      pkgs = pkgs-unstable;  # FIXME: switch to stable when 24.11 become stable
      extraSpecialArgs = { inherit inputs pkgs pkgs-unstable home-manager vars; };
      modules = defaultModules ++ [
        ./ziro
        ./ziro/darwin.nix
        ../modules/home-manager/floorp.nix
        ../modules/home-manager/zen.nix
      ];
    };

  "ziro@potato" =
    let
      inherit (
        mkSystem {
          arch = "x86_64-linux";
          stable = nixpkgs-stable;
          unstable = nixpkgs-unstable;
          nur = nur;
        }
      ) system pkgs pkgs-unstable;
    in
    home-manager.lib.homeManagerConfiguration {
      pkgs = pkgs-unstable;  # FIXME: switch to stable when 24.11 become stable
      extraSpecialArgs = { inherit inputs pkgs pkgs-unstable home-manager vars; };
      modules = defaultModules ++ [
        ./ziro
        ./ziro/linux.nix
        ../modules/home-manager/floorp.nix
        ../modules/home-manager/zen.nix
      ];
    };
}
