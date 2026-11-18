#!/usr/bin/env bash
WAYBAR_PID=$(pgrep waybar)

if [ -z "$WAYBAR_PID" ]; then
  # If Waybar is not running, start it
  waybar &
else
  # If Waybar is running, send SIGUSR1 to hide it
  # If Waybar is running, send SIGUSR2 to reload it
  # If Waybar is running, send 9 to kill it
  kill -9 $WAYBAR_PID
fi
