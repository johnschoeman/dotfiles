{ pkgs, ... }:
{
  systemd.user.services.battery-notify = {
    Unit.Description = "Low battery notification";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /home/john/dotfiles/scripts/battery-notify.sh";
      Environment = [
        "PATH=${pkgs.lib.makeBinPath [ pkgs.coreutils pkgs.libnotify ]}"
      ];
    };
  };

  systemd.user.timers.battery-notify = {
    Unit.Description = "Poll battery level for low notification";
    Timer = {
      OnBootSec = "1min";
      OnUnitActiveSec = "1min";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
