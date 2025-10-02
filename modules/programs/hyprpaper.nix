{ pkgs, ... }:
let
  wallpaper = builtins.toString ./../../../assets/wallpapers/wall3.png;
in
{
  home.packages = with pkgs; [ hyprpaper ];

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      preload = [ wallpaper ];
      wallpaper = [ "eDP-1, ${wallpaper}" ];
    };
  };
}
