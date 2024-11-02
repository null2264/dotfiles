{ pkgs, pkgs-unstable, ... }:

let
  custom = {
    python = (pkgs.python312Full.withPackages (py: [
      py.pip
      py.tkinter
      py.dnspython
    ]));
  };
  custom.inkscape = if pkgs.stdenv.isDarwin then pkgs.inkscape-bin else (pkgs.inkscape.override { python3 = custom.python; });
in {
  inherit custom;
  packages = [
    pkgs.zsh
    pkgs.home-manager
    pkgs.zoxide
    custom.inkscape
  ];
}
