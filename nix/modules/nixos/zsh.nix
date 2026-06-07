{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    # Mimic the behaviour of the setup we had for non-nix setup when running
    # `zsh-xdg-setup`, may or may not break something.
    shellInit = ''
      export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
    '';
  };
}
