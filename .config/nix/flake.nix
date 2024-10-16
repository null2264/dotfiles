{
  description = "null2264's Nix Setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, system-manager }:
  let
    vars = {
      user = "ziro";  # TODO: Make it possible to setup multi-user
      rev = self.rev or self.dirtyRev or null;
    };
  in
  {
    darwinConfigurations = (
      import ./systems/darwin {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nix-darwin home-manager vars;
      }
    );

    # FIXME: Not yet functional
    systemConfigs = (
      import ./systems/nix {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs system-manager home-manager vars;
      }
    );
  };
}
