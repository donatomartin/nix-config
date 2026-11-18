{ pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar # wayland bar
    pavucontrol # audio GUI manager
    nmgui # network manager GUI
    networkmanagerapplet # network manager GUI
  ];
}
