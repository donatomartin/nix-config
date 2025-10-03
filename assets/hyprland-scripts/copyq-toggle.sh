#!/usr/bin/env bash
if hyprctl clients | grep -q "com.github.hluk.copyq"
then
	hyprctl dispatch closewindow class:com.github.hluk.copyq
else
	copyq show
fi
