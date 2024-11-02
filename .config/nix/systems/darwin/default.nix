{ inputs, nixpkgs-stable, nixpkgs-unstable, nix-darwin, brew-api, vars, ... }:

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
      system = "x86_64-darwin";
      inherit (
        mkSystem {
          arch = system;
          stable = nixpkgs-stable;
          unstable = nixpkgs-unstable;
          extraOverlays = [
            inputs.firefox-darwin.overlay
            (import ../../overlays/darwin/brew.nix {
              inherit system brew-api;
              nixpkgs = nixpkgs-stable;
            })
            (import ../../overlays/darwin/inkscape.nix)
          ];
        }
      ) pkgs pkgs-unstable;
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
      system = "aarch64-darwin";
      inherit (
        mkSystem {
          arch = system;
          stable = nixpkgs-stable;
          unstable = nixpkgs-unstable;
          extraOverlays = [
            inputs.firefox-darwin.overlay
            (import ../../overlays/darwin/brew.nix {
              inherit system brew-api;
              nixpkgs = nixpkgs-stable;
            })
            (import ../../overlays/darwin/inkscape.nix)
          ];
        }
      ) pkgs pkgs-unstable;
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
