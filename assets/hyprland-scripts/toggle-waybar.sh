# Toggle Waybar visibility
WAYBAR_PID=$(pgrep waybar)

if [ -z "$WAYBAR_PID" ]; then
  # If Waybar is not running, start it
  waybar &
else
  # If Waybar is running, send SIGUSR1 to hide it
  kill -USR1 $WAYBAR_PID
fi
