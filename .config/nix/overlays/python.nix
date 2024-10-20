final: prev:

let
  disablePyChecks = pkg: pkg.overridePythonAttrs (old: {
    doCheck = false;
    doInstallCheck = false;
    dontCheck = true;
  });
in {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [(pyfinal: pyprev: {
    dnspython = (disablePyChecks pyprev.dnspython).overridePythonAttrs (old: {
      disabledTests = [
        "test_resolver"  # Relying too much on internet connection, Indonesian internet couldn't cope with it
      ] ++ old.disabledTests;
    });
    pillow = disablePyChecks pyprev.pillow;  # Inconsistent test result
    cherrypy = disablePyChecks pyprev.cherrypy;  # Inconsistent test result
  })];
}
