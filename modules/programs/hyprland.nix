{ pkgs, ... }:
let
  copyq-toggle = pkgs.writeShellScript "copyq-toggle"
    (builtins.readFile ../../assets/hyprland-scripts/copyq-toggle.sh);
  toggle-bluelight = pkgs.writeShellScript "toggle-bluelight"
    (builtins.readFile ../../assets/hyprland-scripts/toggle-bluelight.sh);
  hyprpicker-copypick = pkgs.writeShellScript "hyprpicker-copypick"
    (builtins.readFile ../../assets/hyprland-scripts/hyprpicker-copypick.sh);
  toggle-waybar = pkgs.writeShellScript "toggle-waybar"
    (builtins.readFile ../../assets/hyprland-scripts/toggle-waybar.sh);
  catppuccin-power-menu-theme =
    builtins.toString ../../assets/rofi-themes/catppuccin-power-menu.rasi;
  catppuccin-actions-mode-script =
    builtins.toString ../../assets/hyprland-scripts/rofi-actions.sh;
  catppuccin-power-menu-script =
    builtins.replaceStrings [
      "@CATPPUCCIN_POWER_MENU_THEME@"
      "@CATPPUCCIN_ACTIONS_MODE_SCRIPT@"
    ] [
      catppuccin-power-menu-theme
      catppuccin-actions-mode-script
    ]
    (builtins.readFile ../../assets/hyprland-scripts/catppuccin-power-menu.sh);
  hyprland-power-menu =
    pkgs.writeShellScript "hyprland-power-menu" catppuccin-power-menu-script;
in {

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    configType = "lua";
  };

  xdg.configFile."hypr/hyprland.lua".text = ''
    local mainMod = "SUPER"

    -- Nix store paths para los scripts generados en build time
    local powerMenu          = "${hyprland-power-menu}"
    local copyqToggle        = "${copyq-toggle}"
    local toggleBluelight    = "${toggle-bluelight}"
    local hyprpickerCopypick = "${hyprpicker-copypick}"
    local toggleWaybar       = "${toggle-waybar}"

    -- Monitores
    hl.monitor({ output = "eDP-1",    mode = "1920x1080@60", position = "0x0",    scale = 1 })
    hl.monitor({ output = "HDMI-A-2", mode = "1920x1080@60", position = "1920x0", scale = 1 })

    -- Variables de entorno
    hl.env("MOZ_ENABLE_WAYLAND",      "1")
    hl.env("WLR_NO_HARDWARE_CURSORS", "1")

    -- Autostart (equivalente a exec-once)
    hl.on("hyprland.start", function()
      hl.exec_cmd("mako")
      hl.exec_cmd("waybar")
      hl.exec_cmd("copyq --start-server")
      hl.exec_cmd("gammastep -O 4000")
      hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic")
    end)

    -- Configuración general
    hl.config({
      cursor = { no_hardware_cursors = true },

      input = {
        kb_layout          = "es",
        follow_mouse       = 1,
        sensitivity        = 0,
        numlock_by_default = true,
        touchpad = {
          natural_scroll       = false,
          disable_while_typing = false,
        },
      },

      general = {
        gaps_in    = 0,
        gaps_out   = 0,
        border_size = 1,
        col = {
          active_border   = { colors = { "rgba(cba6f7ee)", "rgba(b4befeee)" }, angle = 45 },
          inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing    = true,
        layout           = "dwindle",
      },

      decoration = {
        rounding         = 0,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
          enabled      = false,
          range        = 4,
          render_power = 3,
          color        = "rgba(1a1a1aee)",
        },
        blur = {
          enabled  = false,
          size     = 5,
          vibrancy = 0.1696,
        },
      },

      animations = { enabled = true },

      dwindle = {
        preserve_split = true,
      },

      misc = {
        disable_hyprland_logo = true,
        background_color      = "rgb(11121b)",
      },
    })

    -- Curvas bezier
    hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 }   } })
    hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 }   } })
    hl.curve("linear",         { type = "bezier", points = { { 0, 0 },       { 1, 1 }       } })
    hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },   { 0.75, 1.0 } } })
    hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },    { 0.1, 1 }    } })

    -- Animaciones
    hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default"       })
    hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint"  })
    hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint"  })
    hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
    hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
    hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear"  })
    hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear"  })
    hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick"         })
    hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint"  })
    hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
    hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
    hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear"  })
    hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear"  })
    hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
    hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
    hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

    -- Reglas de ventana
    hl.window_rule({ match = { class = ".*" },                                                                                suppress_event = "maximize" })
    hl.window_rule({ match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false }, no_focus = true })
    hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, opacity = "0.0"        })
    hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_anim = true         })
    hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_initial_focus = true })
    hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, max_size = "1 1"       })
    hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_blur = true         })
    hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_focus = true        })
    hl.window_rule({ match = { title = "^(Chromium-browser)$" },    tile = true            })

    -- Atajos: Lanzadores
    hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd("brave"))
    hl.bind(mainMod .. " + Q",         hl.dsp.exec_cmd("kitty"))
    hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd("thunar"))
    hl.bind(mainMod .. " + W",         hl.dsp.exec_cmd(powerMenu .. " drun"))
    hl.bind(mainMod .. " + Z",         hl.dsp.exec_cmd(powerMenu .. " window"))
    hl.bind(mainMod .. " + X",         hl.dsp.exec_cmd(powerMenu .. " actions"))
    hl.bind(mainMod .. " + V",         hl.dsp.exec_cmd(copyqToggle))
    hl.bind(mainMod .. " + PERIOD",    hl.dsp.exec_cmd("rofimoji --action copy"))
    hl.bind(mainMod .. " + C",         hl.dsp.window.close())
    hl.bind(mainMod .. " + CTRL + M",  hl.dsp.exit())
    hl.bind(mainMod .. " + U",         hl.dsp.exec_cmd(toggleWaybar))
    hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(hyprpickerCopypick))
    hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(toggleBluelight))
    hl.bind(mainMod .. " + M",         hl.dsp.exec_cmd("makoctl dismiss -a"))
    hl.bind("XF86Calculator",          hl.dsp.exec_cmd("libreoffice --calc"))

    -- Atajos: Flotante / pseudotile
    hl.bind(mainMod .. " + O", hl.dsp.window.float({ action = "toggle" }))
    hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
    hl.bind(mainMod .. " + I", hl.dsp.layout("togglesplit"))

    -- Atajos: Foco (estilo vim)
    hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left"  }))
    hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
    hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up"    }))
    hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down"  }))

    -- Atajos: Mover ventanas (en tiling)
    hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left"  }))
    hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
    hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up"    }))
    hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down"  }))

    -- Atajos: Swap de ventanas
    hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.swap({ direction = "left"  }))
    hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.swap({ direction = "right" }))
    hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.swap({ direction = "up"    }))
    hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.swap({ direction = "down"  }))

    -- Atajos: Workspaces 1-10
    for i = 1, 9 do
      hl.bind(mainMod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
      hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
    end
    hl.bind(mainMod .. " + 0",         hl.dsp.focus({ workspace = 10 }))
    hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

    -- Special workspace (scratchpad)
    hl.bind(mainMod .. " + G",         hl.dsp.workspace.toggle_special("magic"))
    hl.bind(mainMod .. " + SHIFT + G", hl.dsp.window.move({ workspace = "special:magic" }))

    -- Navegación entre workspaces
    hl.bind(mainMod .. " + SHIFT + N", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(mainMod .. " + SHIFT + P", hl.dsp.focus({ workspace = "e-1" }))

    -- Capturas de pantalla
    hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -z -m region -o ~/Documents/screenshots/"))
    hl.bind(mainMod .. " + S",         hl.dsp.exec_cmd("hyprshot -z -m output -o ~/Documents/screenshots/"))

    -- Ratón: mover y redimensionar ventanas
    hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
    hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    -- Redimensionar con teclado (repetible)
    hl.bind(mainMod .. " + ALT + h", hl.dsp.window.resize({ x = -40, y = 0   }), { repeating = true })
    hl.bind(mainMod .. " + ALT + l", hl.dsp.window.resize({ x =  40, y = 0   }), { repeating = true })
    hl.bind(mainMod .. " + ALT + k", hl.dsp.window.resize({ x = 0,   y = -40 }), { repeating = true })
    hl.bind(mainMod .. " + ALT + j", hl.dsp.window.resize({ x = 0,   y =  40 }), { repeating = true })

    -- Mover ventana flotante con teclado (repetible)
    hl.bind(mainMod .. " + ALT + SHIFT + h", hl.dsp.window.move({ x = -40, y = 0   }), { repeating = true })
    hl.bind(mainMod .. " + ALT + SHIFT + l", hl.dsp.window.move({ x =  40, y = 0   }), { repeating = true })
    hl.bind(mainMod .. " + ALT + SHIFT + k", hl.dsp.window.move({ x = 0,   y = -40 }), { repeating = true })
    hl.bind(mainMod .. " + ALT + SHIFT + j", hl.dsp.window.move({ x = 0,   y =  40 }), { repeating = true })

    -- Volumen (bloqueado + repetible)
    hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),    { locked = true, repeating = true })
    hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),    { locked = true, repeating = true })
    hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),   { locked = true, repeating = true })
    hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 5%+"),                          { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"),                          { locked = true, repeating = true })

    -- Controles de multimedia (bloqueado)
    hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
    hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
  '';
}
