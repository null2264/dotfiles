{ inputs, nixpkgs, system-manager, vars, ... }:

let
  mkCommon = import ../../lib/mkCommon.nix;
  mkSystem = import ../../lib/mkSystem.nix;
in
{
  "potato" =
    let
      inherit (mkSystem "x86_64-linux" nixpkgs) system pkgs;
      common = (mkCommon pkgs);
    in
    system-manager.lib.makeSystemConfig {
      inherit system;
      specialArgs = { inherit inputs pkgs vars common; };
      modules = [
        ./configuration.nix
      ];
    };
}
