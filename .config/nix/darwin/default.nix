{ inputs, nixpkgs, nix-darwin, home-manager, vars, ... }:

let
  disablePyChecks = pkg: pkg.overridePythonAttrs (old: {
    doCheck = false;
    doInstallCheck = false;
    dontCheck = true;
  });
  systemConfig = system: {
    system = system;
    pkgs = import nixpkgs {
      inherit system;
      overlays = [(final: prev: {
        pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [(pyfinal: pyprev: {
          dnspython = (disablePyChecks pyprev.dnspython).overridePythonAttrs (old: {
            disabledTests = [
              # This test is unreliable when my internet is throttled by Indonesian ISP, timeout everywhere... lovely...
              "test_resolver"
            ] ++ old.disabledTests;
          });
          pillow = disablePyChecks pyprev.pillow;
          cherrypy = disablePyChecks pyprev.cherrypy;
        })];
      })];
      config.allowUnfree = true;
    };
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
      inherit (systemConfig "x86_64-darwin") system pkgs;
    in
    nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit inputs pkgs home-manager vars; };
      modules = [
        ./configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];
    };

  # Imaginary M1, just for reference
  MacBookProM1 =
    let
      inherit (systemConfig "aarch64-darwin") system pkgs;
    in
    nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit inputs pkgs home-manager vars; };
      modules = [
        ./configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];
    };
}
