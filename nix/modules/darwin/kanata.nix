{ pkgs, ... }:

let
  # Figure out how to do multi-user here now that nix-darwin forced you to use root
  user = "ziro";
in {
  launchd.user.agents.kanata = {
    command = "/usr/bin/sudo /run/current-system/sw/bin/kanata -c ${../../../include/kanata.kbd} -n";
    serviceConfig = {
      UserName = user;
      RunAtLoad = true;
      KeepAlive = {
        SuccessfulExit = false;
        Crashed = true;
      };
      StandardErrorPath = "/Users/${user}/.logs/kanata.err.log";
      StandardOutPath = "/Users/${user}/.logs/kanata.out.log";
      ProcessType = "Interactive";
      Nice = -30;
    };
  };

  security.sudo.extraConfig = ''
    ${user} ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/kanata
  '';
}
