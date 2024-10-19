{ inputs, nixpkgs, home-manager, vars, ... }:

let
  mkSystem = import ../lib/mkSystem.nix;
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
      inherit (mkSystem "x86_64-darwin" nixpkgs) system pkgs;
      vars.name = "ziro";
    in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs pkgs home-manager vars; };
      modules = [
        ./ziro
        ./ziro/darwin.nix
      ];
    };

  "ziro@potato" =
    let
      inherit (mkSystem "x86_64-linux" nixpkgs) system pkgs;
      vars.name = "ziro";
    in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs pkgs home-manager vars; };
      modules = [
        ./ziro
        ./ziro/linux.nix
        ../modules/home-manager/floorp.nix
      ];
    };
}
