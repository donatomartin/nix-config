{ ... }:

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
          tooltip-format = "{:%A, %d %B %Y}";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}{capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{icon}{time}";
          format-full = " {capacity}%";
          format-icons = [
            " "
            " "
            " "
            " "
          ];
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
      /* Catppuccin Mocha palette */
      @define-color rosewater #f5e0dc;
      @define-color flamingo #f2cdcd;
      @define-color pink #f5c2e7;
      @define-color mauve #cba6f7;
      @define-color red #f38ba8;
      @define-color maroon #eba0ac;
      @define-color peach #fab387;
      @define-color yellow #f9e2af;
      @define-color green #a6e3a1;
      @define-color teal #94e2d5;
      @define-color sky #89dceb;
      @define-color sapphire #74c7ec;
      @define-color blue #89b4fa;
      @define-color lavender #b4befe;
      @define-color text #cdd6f4;
      @define-color subtext1 #bac2de;
      @define-color subtext0 #a6adc8;
      @define-color overlay2 #9399b2;
      @define-color overlay1 #7f849c;
      @define-color overlay0 #6c7086;
      @define-color surface2 #585b70;
      @define-color surface1 #45475a;
      @define-color surface0 #313244;
      @define-color base #1e1e2e;
      @define-color mantle #181825;
      @define-color crust #11111b;

      * {
        font-family: JetBrainsMono Nerd Font, sans-serif;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background-color: transparent;
        color: @text;
        border: none;
        padding: 0 10px;
      }

      #workspaces button {
        color: @base;
        background: @lavender;
        padding: 0 10px;
        margin: 5px 4px;
        border-radius: 8px;
      }

      #clock,
      #battery,
      #pulseaudio,
      #network {
        padding: 0 10px;
        margin: 5px 4px;
        background-color: @surface0;
        border-radius: 8px;
        color: @text;
      }

      #clock {
        background-color: @lavender;
        color: @base;
      }

      #battery {
        background-color: @lavender;
        color: @base;
      }

      #pulseaudio {
        background-color: @lavender;
        color: @base;
      }

      #network {
        background-color: @lavender;
        color: @base;
      }
    '';
  };
}
