if pkill gammastep
then
notify-send "Bluelight filter off"
else
gammastep -O 4000 &
notify-send "Bluelight filter on"
fi
