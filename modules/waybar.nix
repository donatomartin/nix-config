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

    style = ''
      * {
        font-family: JetBrainsMono Nerd Font, sans-serif;
        font-size: 13px;
      }

      window#waybar {
        background-color: rgba(30, 30, 30, 0.8);
        color: #ffffff;
      }
    '';
  };
}
