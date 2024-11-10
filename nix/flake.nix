{
  description = "null2264's Nix Setup";

  outputs = inputs@{ self, nix-darwin, brew-api, nixpkgs-stable, nixpkgs-unstable, home-manager, system-manager, nur, ... }:
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
        inherit inputs nixpkgs-stable nixpkgs-unstable nur nix-darwin brew-api home-manager vars;
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
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/release-24.05";  # FIXME: p11-kit failed to build
    nixpkgs-stable.url = "github:NixOS/nixpkgs/f39f1d2a8fe191e442ce641a6dc1320f6aa17d04";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/2d2a9ddbe3f2c00747398f3dc9b05f7f2ebb0f53";
    nur.url = "github:nix-community/NUR";

    flake-utils.url = "github:numtide/flake-utils";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/64c6325b28ebd708653dd41d88f306023f296184";
      inputs.nixpkgs.follows = "nixpkgs-unstable";  # we need unstable (24.11) for programs.floorp. FIXME: switch to stable once 24.11 become stable
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/189d2d422c773fa065cc9c72e6806f007ebb9be0";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    firefox-darwin = {
      url = "github:bandithedoge/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    brew-api = {
      url = "github:null2264/brew-api";
      flake = false;
    };

    system-manager = {
      url = "github:numtide/system-manager/c93e62f2e962b54fd961798731d25eaa5778dbe2";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };
}
