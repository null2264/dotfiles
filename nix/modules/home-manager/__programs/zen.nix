{ config, lib, pkgs, home-manager, ... }:
with lib;
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;

  modulePath = [ "programs" "zen" ];
  cfg = getAttrFromPath modulePath config;

  mkFirefoxModule = import "${home-manager.outPath}/modules/programs/firefox/mkFirefoxModule.nix";

  # Because Zen required ZenAvatarPath to be in profiles.ini
  # REF: https://github.com/nix-community/home-manager/blob/60bb110917844d354f3c18e05450606a435d2d10/modules/programs/firefox/mkFirefoxModule.nix#L55-L69
  profiles = flip mapAttrs' cfg.profiles (_: profile:
    nameValuePair "Profile${toString profile.id}" {
      Name = profile.name;
      Path = if isDarwin then "Profiles/${profile.path}" else profile.path;
      IsRelative = 1;
      Default = if profile.isDefault then 1 else 0;
      ZenAvatarPath = "chrome://browser/content/zen-avatars/avatar-1.svg";
    }) // {
      General = {
        StartWithLastProfile = 1;
      } // lib.optionalAttrs (cfg.profileVersion != null) {
        Version = cfg.profileVersion;
      };
    };

  profilesIni = generators.toINI { } profiles;
in {
  imports = [
    (mkFirefoxModule {
      inherit modulePath;
      name = "Zen Browser";
      wrappedPackageName = "zen";  # Imaginary wrappedPackageName so `programs.zen.policies` is added properly
      visible = true;

      platforms.linux = rec {
        vendorPath = ".zen";
        configPath = "${vendorPath}";
      };
      platforms.darwin = rec {
        vendorPath = "Library/Application Support/Zen";
        configPath = "${vendorPath}";
      };
    })
  ];

  config = {
    home.file."${cfg.configPath}/profiles.ini" = mkForce (mkIf (cfg.profiles != { }) { text = profilesIni; });
  };
}
