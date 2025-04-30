{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "network"
          "battery"
          "pulseaudio"
        ];

        clock = {
          format = "{:%H:%M}";
        };

        battery = {
          format = " {capacity}% ";
          format-charging = " {capacity}% ";
        };

        network = {
          format-wifi = "  {essid} ";
          format-ethernet = "󰈀 {ipaddr} ";
          format-disconnected = " Disconnected ";
        };

        pulseaudio = {
          format = "  {volume}% ";
        };

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
        };
      };
    };
  };

  catppuccin.waybar.enable = true;
}
