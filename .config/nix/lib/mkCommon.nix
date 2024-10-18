{ pkgs, ... }:

let
  custom = {
    python = (pkgs.python312Full.withPackages (py: [
      py.pip
      py.tkinter
      py.dnspython
    ]));
  };
in {
  inherit custom;
  packages = [
    pkgs.zsh
    pkgs.home-manager
  ];
}
