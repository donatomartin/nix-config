#!/usr/bin/env bash
set -euo pipefail

readonly ROFI_THEME="@CATPPUCCIN_POWER_MENU_THEME@"
readonly ROFI_PIDFILE="${XDG_RUNTIME_DIR:-/tmp}/catppuccin-power-menu.pid"

format_datetime() {
  date '+%A, %B %d • %I:%M %p'
}

format_volume_percent() {
  local raw="$1"

  [[ -z "$raw" ]] && return

  if [[ "$raw" == *% ]]; then
    printf '%s' "$raw"
    return
  fi

  awk -v val="$raw" 'BEGIN { printf "%.0f%%", val * 100 }'
}

extract_volume_value() {
  local data="$1"
  local value

  value=$(printf '%s' "$data" | grep -oE '[0-9]+(\.[0-9]+)?%' | head -n1 || true)
  if [[ -n "$value" ]]; then
    printf '%s' "$value"
    return
  fi

  value=$(printf '%s' "$data" | grep -oE '[0-9]+(\.[0-9]+)?' | head -n1 || true)
  printf '%s' "${value:-}"
}

get_battery_summary() {
  if ! command -v acpi >/dev/null 2>&1; then
    echo 'unavailable'
    return
  fi

  local acpi_line
  acpi_line=$(acpi -b 2>/dev/null | head -n1 || true)
  if [[ -z "$acpi_line" ]]; then
    echo 'unavailable'
    return
  fi

  local status
  status=${acpi_line%%,*}
  status=${status#Battery *: }
  local percentage
  percentage=$(printf '%s' "$acpi_line" | grep -oE '[0-9]+%' | head -n1)

  if [[ -n "$percentage" && -n "$status" ]]; then
    printf '%s (%s)' "$percentage" "$status"
  elif [[ -n "$percentage" ]]; then
    echo "$percentage"
  else
    echo 'unavailable'
  fi
}

get_pactl_default_sink() {
  pactl info 2>/dev/null | awk -F': ' '/Default Sink/ {print $2}' | head -n1
}

get_volume_summary() {
  local percent mute_state sink raw output

  if command -v wpctl >/dev/null 2>&1; then
    output=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null || true)
    raw=$(extract_volume_value "$output")
    percent=$(format_volume_percent "$raw")
    mute_state=$(wpctl get-mute @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk -F': ' '{print tolower($2)}' || true)
  elif command -v pactl >/dev/null 2>&1; then
    sink=$(get_pactl_default_sink)
    if [[ -z "$sink" ]]; then
      echo 'unavailable'
      return
    fi
    output=$(pactl get-sink-volume "$sink" 2>/dev/null || true)
    raw=$(extract_volume_value "$output")
    percent=$(format_volume_percent "$raw")
    mute_state=$(pactl get-sink-mute "$sink" 2>/dev/null | awk -F': ' '{print tolower($2)}' || true)
  else
    echo 'unavailable'
    return
  fi

  if [[ -z "$percent" ]]; then
    echo 'unavailable'
    return
  fi

  if [[ "$mute_state" == 'true' ]]; then
    printf '%s (muted)' "$percent"
  else
    echo "$percent"
  fi
}

cleanup_pidfile() {
  rm -f "$ROFI_PIDFILE"
}

toggle_existing_menu() {
  if [[ -f "$ROFI_PIDFILE" ]]; then
    local pid
    pid=$(<"$ROFI_PIDFILE")
    if [[ -n "$pid" && -e "/proc/$pid" ]]; then
      kill "$pid" >/dev/null 2>&1 || true
      cleanup_pidfile
      exit 0
    fi
    cleanup_pidfile
  fi
}

main() {
  trap cleanup_pidfile EXIT
  toggle_existing_menu

  if [[ ! -f "$ROFI_THEME" ]]; then
    echo "missing theme: $ROFI_THEME" >&2
    exit 1
  fi

  local datetime battery volume info_line choice
  datetime=$(format_datetime)
  battery=$(get_battery_summary)
  volume=$(get_volume_summary)
  info_line="󰁹 ${battery} •   ${volume}
 ${datetime}"

  mapfile -t options <<'OPTION_LIST'
󰗽  Logout
  Reboot
󰐥  Poweroff
OPTION_LIST

  choice=$(printf '%s\n' "${options[@]}" | rofi \
    -theme "$ROFI_THEME" \
    -dmenu -i -lines 3 \
    -no-custom -mesg "$info_line" -p '' \
    -name catppuccin-power-menu \
    -pid "$ROFI_PIDFILE" \
    -kb-custom-1 '' 2>/dev/null)

  [[ -z "$choice" ]] && exit 0

  case "$choice" in
    *Logout*) hyprctl dispatch exit ;; 
    *Reboot*) shutdown --reboot now ;;
    *Poweroff*) shutdown now ;;
  esac
}

main "$@"
