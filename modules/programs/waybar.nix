{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {

        layer = "top";
        position = "top";
        height = 30;

        modules-left = [ 
          "hyprland/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "keyboard-state"
          "bluetooth"
          "network"
          "battery"
          "pulseaudio"
        ];

        keyboard-state = {
          numlock = true;
          format = {
            numlock = "{icon}";
          };
          format-icons = {
                "locked" = " ";
                "unlocked" = " ";
          };
        };

        bluetooth = {
          # "controller": "controller1"; # specify the alias of the controller if there are more than 1 on the system
          format = " ";
          format-disabled = ""; # an empty format will hide the module
          format-connected = "  {num_connections}";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          on-click = "blueman-manager";
          interval = 1;
        };

        clock = {
          format = "{:%H:%M:%S}";
          tooltip-format = "{:%A, %d %B %Y}";
          interval = 1;
          on-click = "brave --app=https://calendar.google.com --ozone-platform-hint=wayland";
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
          format-full = "  {capacity}%";
          format-icons = [
            "󰂎 "
            "󰁻 "
            "󰁼 "
            "󰁽 "
            "󰁾 "
            "󰁿 "
            "󰂀 "
            "󰂁 "
            "󰂂 "
            "󰁹 "
          ];
          interval = 1;

        };

        network = {
          format-wifi = "󰤨  {signalStrength}%";
          format-ethernet = "󰈀 ";
          format-disconnected = "  ";
          format-disabled = "󰤮 ";
          tooltip-format = "{essid} ({ipaddr})";
          on-click = "nm-connection-editor";
          format-icons = [
            "󰤟 "
            "󰤢 "
            "󰤥 "
            "󰤨 "
          ];
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
            headphone = " ";
          };
          on-click = "pavucontrol";
        };

        "hyprland/workspaces" = {
           all-outputs = false;
           format = "{icon}";
           format-icons = {
             "1" = "󰈹";
             "2" = "";
             "3" = "";
             "4" = "";
             "5" = "";
             "6" = "";
             "7" = "󰕮";
             "8" = "";
             "9" = "";
             "10" = "󰊖";
           };
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

      window#waybar {
        background: linear-gradient(to bottom, rgba(0,0,0,0.4), rgba(0,0,0,0));
        color: @text;
        border: none;
        min-height: 30px;
        padding: 0;
      }

      #window {
        background: @base;
        border: 1px solid @surface1;
        border-radius: 5px;
        padding: 0 5px;
        margin: 5px 5px 5px 10px;
        min-width: 200px;
      }

      #workspaces button,
      #clock, #battery, #pulseaudio, #network {
        margin: 0;
        border-radius: 0;
        background: transparent;
        padding: 0 10px;
      }

      #workspaces button {
        color: @subtext1;
      }
      #workspaces button.active {
        color: @blue;
      }
      #workspaces button:hover {
        box-shadow: none;
        color: @blue;
      }

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
