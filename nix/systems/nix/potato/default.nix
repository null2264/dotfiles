{ pkgs, pkgs-unstable, config, vars, common, ... }:

{
  config = {
    system-manager.allowAnyDistro = true;

    # NOTE: List packages installed in system profile. To search by name, run:
    # `nix-env -qaP | grep wget`
    environment = {
      etc = {
        "nix/nix.conf".text =
          ''
            trusted-users = [ root @wheel ]
            experimental-features = nix-command flakes
            build-users-group = nixbld
          '';
      };
      systemPackages =
        common.packages ++ [
          pkgs.system-manager
        ];
    };

    nixpkgs.hostPlatform = pkgs.system;
  };
}
