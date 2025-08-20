{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30; # fixed height for a crisp bar

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "network"
          "battery"
          "pulseaudio"
        ];

        clock = {
          format = "{:%H:%M:%S}";
          tooltip-format = "{:%A, %d %B %Y}";
          interval = 1;
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
          format-wifi = "  {ipaddr}";
          format-ethernet = "󰈀 {ipaddr}";
          format-disconnected = " Disconnected";
          tooltip-format = "{essid} ({signalStrength}%)";
        };

        pulseaudio = {
          format = "{icon}{volume}%";
          format-muted = "  Muted";
          format-icons = {
            default = [
              "  "
              "  "
              "  "
            ];
            headphone = "";
          };
          on-click = "pavucontrol";
        };

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
        };
      };
    };

    style = ''
      /* Catppuccin Mocha */
      @define-color rosewater #f5e0dc;
      @define-color flamingo   #f2cdcd;
      @define-color pink       #f5c2e7;
      @define-color mauve      #cba6f7;
      @define-color red        #f38ba8;
      @define-color maroon     #eba0ac;
      @define-color peach      #fab387;
      @define-color yellow     #f9e2af;
      @define-color green      #a6e3a1;
      @define-color teal       #94e2d5;
      @define-color sky        #89dceb;
      @define-color sapphire   #74c7ec;
      @define-color blue       #89b4fa;
      @define-color lavender   #b4befe;
      @define-color text       #cdd6f4;
      @define-color subtext1   #bac2de;
      @define-color subtext0   #a6adc8;
      @define-color overlay2   #9399b2;
      @define-color overlay1   #7f849c;
      @define-color overlay0   #6c7086;
      @define-color surface2   #585b70;
      @define-color surface1   #45475a;
      @define-color surface0   #313244;
      @define-color base       #1e1e2e;
      @define-color mantle     #181825;
      @define-color crust      #11111b;

      * {
        font-family: JetBrainsMono Nerd Font, sans-serif;
        font-size: 13px;
        min-height: 0;
      }

      /* Solid bar, no gaps */
      window#waybar {
        background-color: @base;   /* no transparency */
        color: @text;
        border: none;
        min-height: 30px;
        padding: 0;                /* no outer padding */
      }

      /* No margins or rounded corners anywhere */
      #workspaces button,
      #clock, #battery, #pulseaudio, #network {
        margin: 0;
        border-radius: 0;
        background: transparent;   /* modules inherit bar background */
        padding: 0 10px;
      }

      /* Subtle bottom hairline for modern feel */
      window#waybar {
        border-bottom: 1px solid @surface1;
      }

      /* Compact, professional workspaces */
      #workspaces {
        padding: 0;
      }
      #workspaces button {
        color: @subtext1;
      }
      #workspaces button.active {
        color: @text;
        background: @surface0;
      }
      #workspaces button:hover {
        color: @text;
        background: @surface1;
      }

      /* Section separators without gaps */
      .modules-left > widget:not(:first-child),
      .modules-center > widget:not(:first-child),
      .modules-right > widget:not(:first-child) {
        border-left: 1px solid @surface1;
      }
      .modules-left > widget,
      .modules-center > widget,
      .modules-right > widget {
        padding: 0 10px;
      }

      /* Tooltips: solid theme */
      tooltip {
        background: @mantle;
        color: @text;
        border: 1px solid @surface1;
      }
      tooltip * {
        color: @text;
      }
    '';
  };
}
