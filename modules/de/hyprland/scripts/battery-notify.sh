#!/usr/bin/env bash

THRESHOLD=20
BATTERY_PATH="/sys/class/power_supply/BAT0"
STATUS_FILE="$BATTERY_PATH/status"
CAPACITY_FILE="$BATTERY_PATH/capacity"

while true; do
  if [ -f "$CAPACITY_FILE" ]; then
    STATUS=$(cat "$STATUS_FILE")
    CAPACITY=$(cat "$CAPACITY_FILE")

    if [ "$CAPACITY" -le "$THRESHOLD" ] && [ "$STATUS" = "Discharging" ]; then
      notify-send "⚠️ Battery Low" "Battery is at ${CAPACITY}%. Plug in your charger."
      # Wait longer after a warning to avoid spamming
      sleep 300
    else
      sleep 60
    fi
  else
    sleep 60
  fi
done
