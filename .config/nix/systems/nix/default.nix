{ inputs, nixpkgs, system-manager, home-manager, vars, ... }:

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
  "potato" =
    let
      inherit (systemConfig "x86_64-linux") system pkgs;
    in
    system-manager.lib.makeSystemConfig {
      inherit system;
      specialArgs = { inherit inputs pkgs home-manager vars; };
      modules = [
        ./configuration.nix
        # home-manager.darwinModules.home-manager
        # {
        #   home-manager.useGlobalPkgs = true;
        #   home-manager.useUserPackages = true;
        # }
      ];
    };
}
