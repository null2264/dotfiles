{ inputs, nixpkgs-stable, nixpkgs-unstable, nur, system-manager, vars, ... }:

let
  mkCommon = import ../../lib/mkCommon.nix;
  mkSystem = import ../../lib/mkSystem.nix;
in
{
  "potato" =
    let
      inherit (
        mkSystem {
          arch = "x86_64-linux";
          stable = nixpkgs-stable;
          unstable = nixpkgs-unstable;
          extraOverlays = [
            system-manager.overlays.default
          ];
          nur = nur;
        }
      ) system pkgs pkgs-unstable;
      common = (mkCommon { inherit pkgs pkgs-unstable; });
    in
    system-manager.lib.makeSystemConfig {
      extraSpecialArgs = { inherit inputs pkgs pkgs-unstable vars common; };
      modules = [
        ./potato
      ];
    };
}
