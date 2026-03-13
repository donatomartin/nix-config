#!/usr/bin/env bash
set -euo pipefail

# Compose a small status line for the bottom of the menu.
format_time() {
  date '+%a %b %d %H:%M'
}

get_battery() {
  if command -v acpi >/dev/null 2>&1; then
    acpi -b | awk -F', ' 'NR==1 {print $2}'
  else
    echo 'unavailable'
  fi
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

get_pactl_default_sink() {
  pactl info 2>/dev/null | awk -F': ' '/Default Sink/ {print $2}' | head -n1
}

get_volume() {
  local output raw percent sink

  if command -v wpctl >/dev/null 2>&1; then
    output=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null || true)
    raw=$(extract_volume_value "$output")
  elif command -v pactl >/dev/null 2>&1; then
    sink=$(get_pactl_default_sink)
    if [[ -n "$sink" ]]; then
      output=$(pactl get-sink-volume "$sink" 2>/dev/null || true)
      raw=$(extract_volume_value "$output")
    fi
  fi

  percent=$(format_volume_percent "$raw")

  printf '%s' "${percent:-}"
}

main() {
  time_info=$(format_time)
  battery_info=$(get_battery)
  battery_info=${battery_info:-unavailable}
  volume_info=$(get_volume)
  volume_info=${volume_info:-unavailable}

  rofi -show drun -mesg "$time_info • Battery ${battery_info} • Volume ${volume_info}"
}

main "$@"
