{ pkgs, pkgs-unstable, ... }:

let
  custom = {
    python = (pkgs.python312Full.withPackages (py: [
      py.pip
      py.tkinter
      py.dnspython
    ]));
  };
  custom.inkscape = if pkgs.stdenv.isDarwin then pkgs.casks.inkscape else (pkgs.inkscape.override { python3 = custom.python; });
in {
  inherit custom;
  packages = [
    pkgs.zsh
    pkgs.home-manager
    pkgs.zoxide
    pkgs.ruby
    pkgs._7zz

    pkgs.enchive
    (pkgs.pass.withExtensions (exts: [ exts.pass-otp ]))
    pkgs.gnupg

    pkgs.vesktop
  ];
}
