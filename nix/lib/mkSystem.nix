{ arch, stable, unstable, nur, extraOverlays ? [] }:

let
  overlays = [
    (import ../overlays/python.nix)
    (import ../overlays/vesktop.nix)
  ] ++ extraOverlays;

  # Placed here so that we don't need to specify hash for fetchTarball
  packageOverrides = pkgs: {
    nur = import nur {
      nurpkgs = pkgs;
      inherit pkgs;
    };
  };
in {
  system = arch;
  pkgs = import stable {
    system = arch;
    inherit overlays;
    config.allowUnfree = true;
    config.packageOverrides = packageOverrides;
  };
  pkgs-unstable = import unstable {
    system = arch;
    inherit overlays;
    config.allowUnfree = true;
    # config.packageOverrides = packageOverrides;
  };
}
