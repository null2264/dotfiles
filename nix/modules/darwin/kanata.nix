{ user }:

{ pkgs, ... }:

{
  launchd.user.agents.kanata = {
    command = "/usr/bin/sudo ${pkgs.kanata}/bin/kanata -c ${../../../include/kanata.kbd} -n";
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
    ${user} ALL=(ALL) NOPASSWD: ${pkgs.kanata}/bin/kanata
  '';
}
