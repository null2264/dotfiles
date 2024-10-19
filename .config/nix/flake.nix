{
  description = "null2264's Nix Setup";

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, system-manager }:
  let
    vars = {
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

    systemConfigs = (  # sudo is required, sadly
      import ./systems/nix {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs system-manager home-manager vars;
      }
    );

    homeConfigurations = (
      import ./users {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager vars;
      }
    );
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/ccc0c2126893dd20963580b6478d1a10a4512185";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/64c6325b28ebd708653dd41d88f306023f296184";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
