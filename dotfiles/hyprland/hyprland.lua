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
hl.env("EDITOR", "nvim")

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
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false }, no_focus = true })
hl.window_rule({
  match = { class = "^(xwaylandvideobridge)$" },
  no_blur = true,
  no_focus = true,
  max_size = "1 1",
  no_initial_focus = true,
  no_anim = true,
  opacity = "0.0"
})
hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)$" }, float = true, size = { 800, 450 }, move = { "monitor_w - 800", "31" } })
hl.window_rule({ match = { class = "^(.blueman-manager-wrapped)$" }, float = true, size = { 800, 450 }, move = { "monitor_w - 800", "31" } })
hl.window_rule({ match = { title = "^(.*Network Manager.*)$" }, float = true, size = { 800, 450 }, move = { "monitor_w - 800", "31" } })
hl.window_rule({ match = { title = "^(Chromium-browser)$" }, tile = true })
hl.window_rule({ match = { title = "^(Imagen en imagen)|(Picture in picture)$" }, float = true, pin = true, size = { 800, 450 } })
hl.window_rule({
  name = "bitwarden",
  match = {
    initial_class = "^brave-nngceckbapebfimnlniiiahkandclblb-Default$",
  },
  float = true,
  size = { 480, 600 },
  no_anim = true,
  move = { "monitor_w - 480", "31" },
})
-- hl.window_rule({ match = { title = "^(discord.com está compartiendo tu pantalla.)$" } })

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

-- Atajos: Flotante / pseudotile
hl.bind(mainMod .. " + O", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + I", hl.dsp.layout("togglesplit"))

-- Atajos: Foco (estilo vim)
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + Tab", hl.dsp.window.cycle_next({ bring_active_to_top = true }))

-- Atajos: Mover ventanas (en tiling)
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- Atajos: Swap de ventanas
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.swap({ direction = "down" }))

-- Workspace groups (1-10 and 11-20)
local ws_offset = 0

local function opposite_workspace(id)
  if id >= 1 and id <= 10 then
    return id + 10
  elseif id >= 11 and id <= 20 then
    return id - 10
  end
  return nil
end

-- SUPER + G: Switch to opposite workspace group
hl.bind(mainMod .. " + G", function()
  local ws = hl.get_active_workspace()
  if not ws then return end

  local target = opposite_workspace(ws.id)
  if not target then return end

  ws_offset = target > 10 and 10 or 0
  hl.dispatch(hl.dsp.focus({ workspace = target }))
end, { desc = "Alternar grupo de workspaces" })

-- SUPER + SHIFT + G: Move window and follow to opposite group
hl.bind(mainMod .. " + SHIFT + G", function()
  local ws = hl.get_active_workspace()
  if not ws then return end

  local target = opposite_workspace(ws.id)
  if not target then return end

  ws_offset = target > 10 and 10 or 0

  hl.dispatch(hl.dsp.window.move({
    workspace = target,
    follow = true,
  }))
end, { desc = "Mover ventana y seguir al grupo opuesto" })

-- SUPER + 1..0: Switch workspace
-- SUPER + SHIFT + 1..0: Move focused window
for i = 1, 10 do
  local key = i % 10

  hl.bind(mainMod .. " + " .. key, function()
    hl.dispatch(hl.dsp.focus({
      workspace = ws_offset + i,
    }))
  end)

  hl.bind(mainMod .. " + SHIFT + " .. key, function()
    hl.dispatch(hl.dsp.window.move({
      workspace = ws_offset + i,
    }))
  end)
end

-- Navegación entre workspaces
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("ALT + Tab", hl.dsp.focus({ workspace = "previous" }))

-- Capturas de pantalla
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -z -m region -o ~/Documents/screenshots/"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("hyprshot -z -m output -o ~/Documents/screenshots/"))

-- Ratón: mover y redimensionar ventanas
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Redimensionar con teclado (repetible)
hl.bind(mainMod .. " + ALT + h", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })

-- Mover ventana flotante con teclado (repetible)
hl.bind(mainMod .. " + ALT + SHIFT + h", hl.dsp.window.move({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + SHIFT + l", hl.dsp.window.move({ x = 40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + SHIFT + k", hl.dsp.window.move({ x = 0, y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + SHIFT + j", hl.dsp.window.move({ x = 0, y = 40, relative = true }), { repeating = true })

-- Volumen (bloqueado + repetible)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })

-- Brillo (bloqueado + repetible)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 2.5%+"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 2.5%-"),
  { locked = true, repeating = true })

-- Controles de multimedia (bloqueado)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
