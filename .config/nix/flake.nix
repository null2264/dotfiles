{
  description = "null2264's Nix Setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    vars = {
      rev = self.rev or self.dirtyRev or null;
    };
  in
  {
    darwinConfigurations = (
      import ./darwin {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nix-darwin vars;
      }
    );
  };
}
# vim:set ts=2 sw=2 et:
