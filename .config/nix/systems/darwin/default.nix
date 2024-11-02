{ inputs, nixpkgs-stable, nixpkgs-unstable, nix-darwin, vars, ... }:

let
  mkCommon = import ../../lib/mkCommon.nix;
  mkSystem = import ../../lib/mkSystem.nix;
in
{
  # Host list
  # Build with darwin flake: `darwin-rebuild build --flake .#<host>`
  # e.g. `darwin-rebuild build --flake .#"ThiccBook-Pro"`
  # Switch to current build: `darwin-rebuild switch --flake .#<host>`

  # Lenovo ThinkPad L460; Intel Core i5-6300U
  "ThiccBook-Pro" =
    let
      inherit (
        mkSystem {
          arch = "x86_64-darwin";
          stable = nixpkgs-stable;
          unstable = nixpkgs-unstable;
          extraOverlays = [
            inputs.firefox-darwin.overlay
            inputs.brew-nix.overlays.default
            (import ../../overlays/darwin/inkscape.nix)
          ];
        }
      ) system pkgs pkgs-unstable;
      common = (mkCommon { inherit pkgs pkgs-unstable; });
    in
    nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit inputs pkgs pkgs-unstable vars common; };
      modules = [
        ./configuration.nix
      ];
    };

  # Imaginary M1, just for reference
  MacBookProM1 =
    let
      inherit (
        mkSystem {
          arch = "aarch64-darwin";
          stable = nixpkgs-stable;
          unstable = nixpkgs-unstable;
          extraOverlays = [
            inputs.firefox-darwin.overlay
            inputs.brew-nix.overlays.default
            (import ../../overlays/darwin/inkscape.nix)
          ];
        }
      ) system pkgs pkgs-unstable;
      common = (mkCommon { inherit pkgs pkgs-unstable; });
    in
    nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit inputs pkgs pkgs-unstable vars common; };
      modules = [
        ./configuration.nix
      ];
    };
}
