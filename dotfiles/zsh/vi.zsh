bindkey -v
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
bindkey -M viins '^W' backward-kill-word

# -> system clipboard via OSC52 (works over SSH/tmux) ---
# --- vi yank
_clip() {
  # If inside tmux, use passthrough so the outer terminal receives OSC52
  if [[ -n "$TMUX" ]]; then
    printf '\ePtmux;\e\e]52;c;%s\a\e\\' "$(printf %s "$1" | base64 | tr -d '\n')"
  else
    printf '\e]52;c;%s\a' "$(printf %s "$1" | base64 | tr -d '\n')"
  fi
}

vi_yank_and_clip() { zle vi-yank; _clip "$CUTBUFFER"; }
zle -N vi_yank_and_clip
bindkey -M vicmd 'y'  vi_yank_and_clip
bindkey -M vicmd 'Y'  vi_yank_and_clip
bindkey -M vicmd 'yy' vi_yank_and_clip

# v to edit command in editor
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd V edit-command-line

zstyle :compinstall filename '/home/donato/.zshrc'
zstyle ':completion:*' menu select

autoload -Uz compinit
zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"

if [[ ! -f "$zcompdump" || "$zcompdump" -ot ~/.zshrc ]]; then
  compinit -d "$zcompdump"
else
  compinit -C -d "$zcompdump"
fi

# --- vi paste
vi_paste_from_clip() {
  local content=""

  if grep -qi microsoft /proc/version 2>/dev/null; then
    # WSL
    content=$(powershell.exe -NoProfile -Command "Get-Clipboard" 2>/dev/null | tr -d '\r')

  elif command -v wl-paste >/dev/null 2>&1; then
    # Linux Wayland
    content=$(wl-paste --no-newline 2>/dev/null)

  elif command -v xclip >/dev/null 2>&1; then
    # Linux X11
    content=$(xclip -selection clipboard -o 2>/dev/null)

  elif command -v xsel >/dev/null 2>&1; then
    # Linux X11 alternative
    content=$(xsel --clipboard --output 2>/dev/null)
  fi

  if [[ -n "$content" ]]; then
    KILLRECT=""
    CUTBUFFER="$content"
    zle vi-put-after
  fi
}
# Register and bind
zle -N vi_paste_from_clip
bindkey -M vicmd 'p' vi_paste_from_clip

# Save original if exists and not already saved
if (( ! $+functions[zle_keymap_select_original] )) && (( $+functions[zle-keymap-select] )); then
  functions[zle_keymap_select_original]=$functions[zle-keymap-select]
fi

# Re-entrancy guard for zle-keymap-select to stop recursion loops
typeset -gi _ZKMS_GUARD=0

my_keymap_select_guard() {
  if (( _ZKMS_GUARD > 0 )); then
    return 0
  fi
  (( _ZKMS_GUARD++ ))

  if (( $+functions[zle_keymap_select_original] )); then
    zle zle_keymap_select_original
  fi

  (( _ZKMS_GUARD-- ))
}

# Install guarded wrapper (last writer wins)
zle -N zle-keymap-select my_keymap_select_guard
