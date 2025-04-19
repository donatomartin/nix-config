{
  config,
  lib,
  pkgs,
  ...
}:
let
  wallpaperPath = builtins.toString ./../wallpapers/wall1.png;
in
{
  home.packages = with pkgs; [ hyprpaper ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${wallpaperPath}
    wallpaper = eDP-1,${wallpaperPath}
  '';

  systemd.user.services.hyprpaper = {
    Unit = {
      Description = "Hyprpaper wallpaper daemon";
      After = [ "hyprland-session.target" ];
      PartOf = [ "hyprland-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "hyprland-session.target" ];
    };
  };

  systemd.user.startServices = true;
}
