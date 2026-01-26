{
  description = "null2264's Nix Setup";

  outputs = inputs@{ self, nix-darwin, brew-nix, nixpkgs-stable, nixpkgs-unstable, home-manager, system-manager, nur, ... }:
  let
    utils = inputs.flake-utils.lib;

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
        inherit (nixpkgs-unstable) lib;
        inherit inputs nixpkgs-stable nixpkgs-unstable nur nix-darwin brew-nix home-manager vars;
      }
    );

    systemConfigs = (  # sudo is required, sadly
      import ./systems/nix {
        inherit (nixpkgs-unstable) lib;
        inherit inputs nixpkgs-stable nixpkgs-unstable nur system-manager home-manager vars;
      }
    );

    homeConfigurations = (
      import ./users {
        inherit (nixpkgs-unstable) lib;
        inherit inputs nixpkgs-stable nixpkgs-unstable nur home-manager vars;
      }
    );
  };

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";
    nur.url = "github:nix-community/NUR";

    flake-utils.url = "github:numtide/flake-utils";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    firefox-darwin = {
      url = "github:null2264/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    brew-api = {
      url = "github:null2264/brew-api";
      flake = false;
    };
    brew-nix = {
      url = "github:BatteredBunny/brew-nix";
      inputs.brew-api.follows = "brew-api";
    };

    system-manager = {
      url = "github:numtide/system-manager/c93e62f2e962b54fd961798731d25eaa5778dbe2";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };
}
