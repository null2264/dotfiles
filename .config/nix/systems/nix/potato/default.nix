{ pkgs, config, vars, common, ... }:

{
  config = {
    system-manager.allowAnyDistro = true;

    # NOTE: List packages installed in system profile. To search by name, run:
    # `nix-env -qaP | grep wget`
    environment.systemPackages =
      common.packages ++ [
        pkgs.zoxide
      ];

    nixpkgs.hostPlatform = pkgs.system;
  };
}
