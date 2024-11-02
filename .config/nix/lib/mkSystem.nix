{ arch, stable, unstable, extraOverlays ? [] }:

{
  system = arch;
  pkgs = import stable {
    system = arch;
    overlays =
      [
        (import ../overlays/python.nix)
      ] ++ extraOverlays;
    config.allowUnfree = true;
  };
  pkgs-unstable = import unstable {
    system = arch;
    overlays =
      [
        (import ../overlays/python.nix)
      ] ++ extraOverlays;
    config.allowUnfree = true;
  };
}
