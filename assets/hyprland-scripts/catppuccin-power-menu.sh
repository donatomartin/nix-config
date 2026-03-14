#!/usr/bin/env bash
set -euo pipefail

readonly ROFI_THEME="@CATPPUCCIN_POWER_MENU_THEME@"
readonly ROFI_PIDFILE="${XDG_RUNTIME_DIR:-/tmp}/catppuccin-power-menu.pid"
readonly ROFI_MODEFILE="${XDG_RUNTIME_DIR:-/tmp}/catppuccin-power-menu.mode"
readonly ROFI_ACTIONS_SCRIPT="@CATPPUCCIN_ACTIONS_MODE_SCRIPT@"
readonly ROFI_ACTIONS_MODE_NAME=">_"

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

  local status percentage
  status=${acpi_line%%,*}
  status=${status#Battery *: }
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

is_valid_mode() {
  case "$1" in
    drun | window | actions) return 0 ;;
    *) return 1 ;;
  esac
}

read_last_mode() {
  if [[ -f "$ROFI_MODEFILE" ]]; then
    local mode
    mode=$(<"$ROFI_MODEFILE")
    if is_valid_mode "$mode"; then
      printf '%s' "$mode"
      return
    fi
  fi
  printf 'drun'
}

escape_for_theme_string() {
  local input="$1"
  input=${input//\\/\\\\}
  input=${input//\"/\\\"}
  input=${input//$'\n'/\\n}
  printf '%s' "$input"
}

toggle_existing_menu() {
  local target_mode="$1"
  local current_mode="$2"

  if [[ -f "$ROFI_PIDFILE" ]]; then
    local pid
    pid=$(<"$ROFI_PIDFILE")
    if [[ -n "$pid" && -e "/proc/$pid" ]]; then
      kill "$pid" >/dev/null 2>&1 || true
      cleanup_pidfile

      if [[ "$target_mode" == "$current_mode" ]]; then
        exit 0
      fi

      sleep 0.05
    else
      cleanup_pidfile
    fi
  fi
}

main() {
  trap cleanup_pidfile EXIT

  if [[ ! -f "$ROFI_THEME" ]]; then
    echo "missing theme: $ROFI_THEME" >&2
    exit 1
  fi
  if [[ ! -f "$ROFI_ACTIONS_SCRIPT" ]]; then
    echo "missing actions script: $ROFI_ACTIONS_SCRIPT" >&2
    exit 1
  fi

  local requested_mode="" arg
  for arg in "$@"; do
    case "$arg" in
      drun | window | actions) requested_mode="$arg" ;;
    esac
  done

  local current_mode target_mode
  current_mode=$(read_last_mode)
  target_mode="${requested_mode:-$current_mode}"
  if ! is_valid_mode "$target_mode"; then
    target_mode="drun"
  fi

  toggle_existing_menu "$target_mode" "$current_mode"

  printf '%s' "$target_mode" >"$ROFI_MODEFILE"

  local datetime battery volume info_line info_theme_str rofi_mode
  datetime=$(format_datetime)
  battery=$(get_battery_summary)
  volume=$(get_volume_summary)
  info_line="System Monitor

Battery: ${battery}
Volume: ${volume}
Date: ${datetime}"
  info_theme_str=$(escape_for_theme_string "$info_line")
  case "$target_mode" in
    actions) rofi_mode="$ROFI_ACTIONS_MODE_NAME" ;;
    *) rofi_mode="$target_mode" ;;
  esac

  set +e
  rofi \
    -theme "$ROFI_THEME" \
    -theme-str "textbox-system-info { str: \"${info_theme_str}\"; }" \
    -show "$rofi_mode" \
    -modi "drun,window,${ROFI_ACTIONS_MODE_NAME}:${ROFI_ACTIONS_SCRIPT}" \
    -drun-display-format "{icon}  {name}" \
    -show-icons \
    -kb-accept-entry "Return,KP_Enter" \
    -kb-remove-to-eol "Control+Shift+k" \
    -kb-mode-next "Control+k" \
    -kb-mode-previous "Control+j" \
    -kb-custom-1 "" \
    -kb-custom-2 "" \
    -kb-custom-3 "" \
    -i \
    -p "Search" \
    -name catppuccin-power-menu \
    -pid "$ROFI_PIDFILE" \
    2>/dev/null
  set -e
}

main "$@"
