{ pkgs, pkgs-unstable, ... }:

let
  custom = {
    python = (pkgs.python312Full.withPackages (py: [
      py.pip
      py.tkinter
      py.dnspython
    ]));
  };
  custom.inkscape =
    if pkgs.stdenv.isDarwin then
      pkgs.casks.inkscape
    else
      (pkgs.inkscape.override { python3 = custom.python; });
  custom.fastfetch =
    if pkgs.stdenv.isDarwin then
      pkgs.fastfetch.override { imagemagick_light = pkgs.imagemagick; }
    else
      pkgs.fastfetch;
in {
  inherit custom;
  packages = [
    pkgs.zsh
    pkgs.home-manager
    pkgs.zoxide
    pkgs.ruby
    pkgs._7zz
    custom.fastfetch

    pkgs.enchive
    (pkgs.pass.withExtensions (exts: [ exts.pass-otp ]))
    pkgs.gnupg

    pkgs.vesktop

    # For hackintosh-ing
    pkgs.acpica-tools
  ];
}
