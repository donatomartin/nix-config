{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    rofi-rbw-wayland
    rofimoji
  ];

  programs.rofi = {
    enable = true;
    extraConfig = {
      show-icons = true;
      icon-theme = "Papirus";
      drun-display-format = "{icon} {name}";
    };
    theme = ../../assets/rofi-themes/theme.rasi;
  };
}
