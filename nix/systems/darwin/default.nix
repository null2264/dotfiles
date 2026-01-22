{ inputs, nixpkgs-stable, nixpkgs-unstable, nur, nix-darwin, brew-nix, vars, ... }:

let
  mkCommon = import ../../lib/mkCommon.nix;
  mkSystem = import ../../lib/mkSystem.nix;
  mkBrew =
    system:
    final: _: {
      casks = brew-nix.packages.${system};
    };
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
            (mkBrew system)
            (import ../../overlays/darwin/heliport.nix)
            (import ../../overlays/darwin/kanata.nix)
            (import ../../overlays/vesktop.nix)
            (import ../../overlays/rclone.nix)  # FIXME: Remove later
          ];
          nur = nur;
        }
      ) pkgs pkgs-unstable;
      common = (mkCommon { inherit pkgs pkgs-unstable; });
      spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
    in
    nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit inputs pkgs pkgs-unstable spicePkgs vars common; };
      modules = [
        inputs.spicetify-nix.nixosModules.default  # Also works on nix-darwin thanks to it being nixosConfiguration replacement for macOS
        ./configuration.nix
        ../../modules/darwin/kanata.nix
        ../../modules/darwin/dnscrypt.nix
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
            (mkBrew system)
            (import ../../overlays/darwin/kanata.nix)
            (import ../../overlays/vesktop.nix)
            (import ../../overlays/rclone.nix)  # FIXME: Remove later
          ];
          nur = nur;
        }
      ) pkgs pkgs-unstable;
      common = (mkCommon { inherit pkgs pkgs-unstable; });
      spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
    in
    nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit inputs pkgs pkgs-unstable spicePkgs vars common; };
      modules = [
        inputs.spicetify-nix.nixosModules.default
        ./configuration.nix
        ../../modules/darwin/kanata.nix
        #../../modules/darwin/dnscrypt.nix
      ];
    };
}
