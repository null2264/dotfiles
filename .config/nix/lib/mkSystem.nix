system: nixpkgs: extraOverlays:

{
  system = system;
  pkgs = import nixpkgs {
    inherit system;
    overlays =
      [
        (import ../overlays/python.nix)
      ] ++ extraOverlays;
    config.allowUnfree = true;
  };
}
