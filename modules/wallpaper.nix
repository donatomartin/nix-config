{ config, lib, pkgs, ... }:

let
  wallpaperPath = builtins.toString ./../wallpapers/wall0.png;
in {
  home.packages = with pkgs; [ swww ];

  systemd.user.services.swww-daemon = {
    Unit = {
      Description = "swww wallpaper daemon";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.services.set-wallpaper = {
    Unit = {
      Description = "Set wallpaper using swww";
      After = [ "swww-daemon.service" ];
      Requires = [ "swww-daemon.service" ];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww img ${wallpaperPath}";
      Type = "oneshot";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # Optional: start services automatically
  systemd.user.startServices = true;
}
