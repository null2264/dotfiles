{
  description = "null2264's Nix Setup";

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, system-manager, ... }:
  let
    vars = {
      floorp = {
        verticalTabHoverWidthInEm = 18;
      };
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
      url = "github:LnL7/nix-darwin/470f87c1827b51169ed4f91cdbdfd48417bfff3d";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-darwin = {
      url = "github:bandithedoge/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    brew-nix = {
      url = "github:BatteredBunny/brew-nix/d3d3a2666e5330e83b6a64b1eb3e1e9380f6da9b";
      inputs.nix-darwin.follows = "nix-darwin";
      inputs.brew-api.follows = "brew-api";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    brew-api = {
      url = "github:BatteredBunny/brew-api";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/64c6325b28ebd708653dd41d88f306023f296184";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    system-manager = {
      url = "github:numtide/system-manager/c93e62f2e962b54fd961798731d25eaa5778dbe2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
