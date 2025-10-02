{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    rofi-wayland
    rofi-rbw-wayland
    rofimoji
  ];

  programs.rofi = {
    package = pkgs.rofi-wayland;
    enable = true;
    extraConfig = {
      show-icons = true;
      icon-theme = "Papirus";
      drun-display-format = "{icon} {name}";
    };
    theme = ../../assets/rofi-themes/theme.rasi;
  };
}
