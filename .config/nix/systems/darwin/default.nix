{ inputs, nixpkgs, nix-darwin, vars, ... }:

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
        mkSystem "x86_64-darwin" nixpkgs [
          inputs.firefox-darwin.overlay
          inputs.brew-nix.overlays.default
        ]
      ) system pkgs;
      common = (mkCommon pkgs);
    in
    nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit inputs pkgs vars common; };
      modules = [
        ./configuration.nix
      ];
    };

  # Imaginary M1, just for reference
  MacBookProM1 =
    let
      inherit (
        mkSystem "aarch64-darwin" nixpkgs [
          inputs.firefox-darwin.overlay
          inputs.brew-nix.overlays.default
        ]
      ) system pkgs;
      common = (mkCommon pkgs);
    in
    nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit inputs pkgs vars common; };
      modules = [
        ./configuration.nix
      ];
    };
}
