{ pkgs, ... }:
let
  rofi-clipboard = pkgs.writeShellScript "rofi-clipboard" (
    builtins.readFile ./scripts/rofi-clipboard.sh
  );
  toggle-hyprshade = pkgs.writeShellScript "toggle-hyprshade" (
    builtins.readFile ./scripts/toggle-hyprshade.sh
  );
  hyprpicker-copypick = pkgs.writeShellScript "hyprpicker-copypick" (
    builtins.readFile ./scripts/hyprpicker-copypick.sh
  );
in
{

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      "$mainMod" = "SUPER";

      exec-once = [
        "mako"
        "waybar &"
        "wl-paste --watch cliphist store &"
        "gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic"
      ];

      env = [
        "MOZ_ENABLE_WAYLAND,1" # Enable Wayland support in Firefox
        "WLR_NO_HARDWARE_CURSORS,1" # Disable hardware cursors
      ];

      input = {
        kb_layout = "es";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(cba6f7ee) rgba(b4befeee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      gestures = {
        workspace_swipe = false;
      };

      misc = {
        disable_hyprland_logo = true;
      };

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "nofocus, class:^(xwaylandvideobridge)$"
      ];

      bind = [

        # Lanzadores
        "$mainMod, B, exec, zen"
        "$mainMod CTRL, B, exec, brave"
        "$mainMod, Q, exec, ghostty"
        "$mainMod, E, exec, thunar"
        "$mainMod, W, exec, rofi -show drun"
        "$mainMod, V, exec, ${rofi-clipboard}"
        "$mainMod, PERIOD, exec, rofimoji --action copy"
        "$mainMod, C, killactive,"
        "$mainMod CTRL, M, exit,"
        "$mainMod, U, exec, pkill waybar --signal=9 || waybar &"
        "$mainMod SHIFT, C, exec, ${hyprpicker-copypick}"
        "$mainMod SHIFT, B, exec, ${toggle-hyprshade}"
        "$mainMod, M, exec, makoctl dismiss -a"
        "CTRL SHIFT, ESC, exec, ghostty -e btop"

        # Flotante/pseudotile
        "$mainMod, O, togglefloating,"
        "$mainMod, P, pseudo,"
        "$mainMod, I, togglesplit,"

        # Movimiento con teclas estilo vim
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Movimiento de ventanas
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"

        # Swap de ventanas
        "$mainMod CTRL, h, swapwindow, l"
        "$mainMod CTRL, l, swapwindow, r"
        "$mainMod CTRL, k, swapwindow, u"
        "$mainMod CTRL, j, swapwindow, d"

        # Workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Special workspace (scratchpad)
        "$mainMod, G, togglespecialworkspace, magic"
        "$mainMod SHIFT, G, movetoworkspace, special:magic"

        # Navegación entre workspaces
        "$mainMod SHIFT, N, workspace, e+1"
        "$mainMod SHIFT, P, workspace, e-1"

        # Screenshot
        "$mainMod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of the region taken\" -t 1000"
        "$mainMod, S, exec, grim - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of whole screen taken\" -t 1000"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binde = [
        # Resize
        "$mainMod ALT, h, resizeactive,-40 0"
        "$mainMod ALT, l, resizeactive,40 0"
        "$mainMod ALT, k, resizeactive,0 -40"
        "$mainMod ALT, j, resizeactive,0 40"

        # Move
        "$mainMod ALT SHIFT, h, moveactive,-40 0"
        "$mainMod ALT SHIFT, l, moveactive,40 0"
        "$mainMod ALT SHIFT, k, moveactive,0 -40"
        "$mainMod ALT SHIFT, j, moveactive,0 40"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };
}
