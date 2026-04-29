#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

echo "---" | tee -a /tmp/polybar_mybar.log

for m in $(polybar --list-monitors | cut -d":" -f1); do
	MONITOR=$m polybar mybar 2>&1 | tee -a /tmp/polybar_mybar.log & disown
done

echo "Bars launched..."
