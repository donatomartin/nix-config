local mainMod            = "SUPER"

local scriptDir          = os.getenv("HOME") .. "/.config/hypr/hyprland-scripts"
local powerMenu          = scriptDir .. "/power-menu.sh"
local toggleBluelight    = scriptDir .. "/toggle-bluelight.sh"
local hyprpickerCopypick = scriptDir .. "/hyprpicker-copypick.sh"
local toggleWaybar       = scriptDir .. "/toggle-waybar.sh"

require("monitors")

-- Variables de entorno
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")

-- Autostart (equivalente a exec-once)
hl.on("hyprland.start", function()
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("mako")
  hl.exec_cmd("copyq")
  hl.exec_cmd("gammastep -O 4000")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic")
end)

-- Configuración general
hl.config({
  cursor = {
    no_hardware_cursors = true,
    hide_on_key_press = true
  },
  input = {
    kb_layout          = "es",
    follow_mouse       = 1,
    sensitivity        = 0,
    numlock_by_default = true,
    touchpad           = {
      natural_scroll       = false,
      disable_while_typing = false,
    },
  },

  general = {
    gaps_in          = 0,
    gaps_out         = 0,
    border_size      = 1,
    col              = {
      active_border   = { colors = { "rgba(cba6f7ee)", "rgba(b4befeee)" }, angle = 45 },
      inactive_border = "rgba(595959ff)",
    },
    resize_on_border = false,
    allow_tearing    = true,
    layout           = "dwindle",
  },

  decoration = {
    rounding         = 0,
    active_opacity   = 1,
    inactive_opacity = 1,
    shadow           = {
      enabled      = false,
      range        = 4,
      render_power = 3,
      color        = "rgba(1a1a1aee)",
    },
    blur             = {
      enabled = false,
      -- size     = 5,
      -- vibrancy = 0.1696,
    },
  },

  animations = { enabled = true },

  dwindle = {
    preserve_split = true,
  },

  misc = {
    disable_hyprland_logo    = true,
    disable_splash_rendering = true,
    background_color         = "rgb(11121b)",
  },
})

-- Curvas bezier
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Animaciones
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- Reglas de ventana
hl.window_rule({
  match = { class = ".*" },
  suppress_event = "maximize"
})
hl.window_rule({
  match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
  no_focus = true
})
hl.window_rule({
  match = { class = "^(xwaylandvideobridge)$" },
  no_blur = true,
  no_focus = true,
  max_size = "1 1",
  no_initial_focus = true,
  no_anim = true,
  opacity = "0.0"
})
hl.window_rule({
  match = { class = "^(org.pulseaudio.pavucontrol)$" },
  float = true,
  size = { 800, 450 },
  move = { "monitor_w - 800", "31" }
})
hl.window_rule({
  match = { class = "^(.blueman-manager-wrapped)$" },
  float = true,
  size = { 800, 450 },
  move = { "monitor_w - 800", "31" }
})
hl.window_rule({
  match = { title = "^(.*Network Manager.*)$" },
  float = true,
  size = { 800, 450 },
  move = { "monitor_w - 800", "31" }
})
hl.window_rule({
  match = { initial_class = "^brave-nngceckbapebfimnlniiiahkandclblb-Default$", },
  float = true,
  size = { 480, 600 },
  move = { "monitor_w - 480", "31" },
})
hl.window_rule({
  match = { title = "^(Chromium-browser)$" },
  tile = true
})
hl.window_rule({
  match = { title = "^(Imagen en imagen)|(Picture in picture)$" },
  float = true,
  pin = true,
  size = { 800, 450 }
})

local function should_close_on_blur(window)
  if not window then return false end

  local class = (window.class or ""):lower()

  return class:find("pavucontrol", 1, true)
      or class:find("blueman-manager", 1, true)
      or class:find("network.manager", 1, true)
end

local previous = hl.get_active_window()

hl.on("window.active", function(current)
  if previous
      and (not current or current.address ~= previous.address)
      and previous.mapped
      and should_close_on_blur(previous)
  then
    hl.dispatch(hl.dsp.window.close({ window = previous }))
  end

  previous = current
end)

-- Atajos: Lanzadores
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brave"))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(powerMenu .. " drun"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(powerMenu .. " window"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(powerMenu .. " actions"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("copyq toggle"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd(toggleWaybar))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(hyprpickerCopypick))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(toggleBluelight))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("makoctl dismiss -a"))
hl.bind("XF86Calculator", hl.dsp.exec_cmd("libreoffice --calc"))

local multiplier = 40
local directions = {
  { direction = "left",  key = "h", coords = { x = -multiplier, y = 0, relative = true } },
  { direction = "down",  key = "j", coords = { x = 0, y = multiplier, relative = true } },
  { direction = "up",   key = "k", coords = { x = 0, y = -multiplier, relative = true } },
  { direction = "right", key = "l", coords = { x = multiplier, y = 0, relative = true } },
}

-- Atajos de Tile
for _, value in ipairs(directions) do
  hl.bind(mainMod .. " + " .. value.key,
    hl.dsp.focus({ direction = value.direction }))
  hl.bind(mainMod .. " + SHIFT + " .. value.key,
    hl.dsp.window.move({ direction = value.direction }))
  hl.bind(mainMod .. " + CTRL + " .. value.key,
    hl.dsp.window.swap({ direction = value.direction }))
  hl.bind(mainMod .. " + ALT + " .. value.key,
    hl.dsp.window.resize(value.coords), { repeating = true })
  hl.bind(mainMod .. " + ALT + SHIFT + " .. value.key,
    hl.dsp.window.move(value.coords), { repeating = true })
end

hl.bind(mainMod .. " + Tab", hl.dsp.window.cycle_next({ bring_active_to_top = true }))
hl.bind(mainMod .. " + O", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + I", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Atajos de Workspace
for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key, function() hl.dispatch(hl.dsp.focus({ workspace = i, })) end)
  hl.bind(mainMod .. " + SHIFT + " .. key, function() hl.dispatch(hl.dsp.window.move({ workspace = i, })) end)
end

hl.bind(mainMod .. " + SHIFT + N", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "previous" }))

-- Capturas de pantalla
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -z -m region -o ~/Documents/screenshots/"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("hyprshot -z -m output -o ~/Documents/screenshots/"))

local ltrue = { locked = true, }
local lrtrue = { locked = true, repeating = true }

-- Volumen (bloqueado + repetible)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), lrtrue)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), lrtrue)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), lrtrue)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), lrtrue)

-- Brillo (bloqueado + repetible)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 2.5%+"), lrtrue)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 2.5%-"), lrtrue)

-- Controles de multimedia (bloqueado)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), ltrue)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), ltrue)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), ltrue)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), ltrue)
