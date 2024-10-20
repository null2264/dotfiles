system: nixpkgs:  # e.g. x86_64-linux

{
  system = system;
  pkgs = import nixpkgs {
    inherit system;
    overlays =
      [
        (import ../overlays/python.nix)
      ];
    config.allowUnfree = true;
  };
}
