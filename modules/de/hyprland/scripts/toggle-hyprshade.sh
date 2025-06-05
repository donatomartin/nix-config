if [ -z "$(hyprshade current)" ]; then
  hyprshade on blue-light-filter
else
  hyprshade off
fi
