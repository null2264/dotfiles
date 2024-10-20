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
        # This test is unreliable when my internet is throttled by Indonesian ISP, timeout everywhere... lovely...
        "test_resolver"
      ] ++ old.disabledTests;
    });
    pillow = disablePyChecks pyprev.pillow;
    cherrypy = disablePyChecks pyprev.cherrypy;
  })];
}
