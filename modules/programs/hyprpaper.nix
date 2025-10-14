{ pkgs, ... }:
let
  wallpaper = builtins.toString ./../../assets/wallpapers/wall.png;
in
{
  home.packages = with pkgs; [ hyprpaper ];

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      preload = [ wallpaper ];
      wallpaper = [ ", ${wallpaper}" ];
    };
  };
}
