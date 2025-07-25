cliphist list | while read -r id rest; do
  if echo "$rest" | grep -q 'binary'; then
    echo "$id.    📷 Image"
  else
    echo "$id.    $rest"
  fi
done | rofi -dmenu -p "Clipboard" | awk '{print $1}' | sed 's/[^0-9]*//g' | xargs -r cliphist decode | wl-copy
