#!/usr/bin/env bash
set -euo pipefail

print_actions() {
  # Keep script mode on the normal rofi flow with custom hotkeys disabled.
  printf '\0use-hot-keys\x1ffalse\n'
  cat <<'EOF'
󰗽  Logout
  Reboot
󰐥  Poweroff
EOF
}

if [[ "${ROFI_RETV:-0}" -eq 0 ]]; then
  print_actions
  exit 0
fi

case "${1:-}" in
  *Logout*) hyprctl dispatch exit ;;
  *Reboot*) shutdown --reboot now ;;
  *Poweroff*) shutdown now ;;
  *) exit 0 ;;
esac
