#!/usr/bin/env bash

# Prevent overlapping runs (e.g. autorandr retriggering rapidly on hotplug)
# from racing each other and leaving duplicate bars behind.
exec 9>/tmp/polybar-launch.lock
flock -n 9 || exit 0

# Terminate already running bar instances and wait for them to actually exit
# before spawning new ones (polybar-msg cmd quit is async and doesn't wait).
polybar-msg cmd quit >/dev/null 2>&1
for _ in $(seq 1 20); do
	pgrep -u "$UID" -x polybar >/dev/null || break
	sleep 0.1
done
pkill -u "$UID" -x polybar 2>/dev/null

echo "---" | tee -a /tmp/polybar_mybar.log

for m in $(polybar --list-monitors | cut -d":" -f1); do
	MONITOR=$m polybar mybar 2>&1 | tee -a /tmp/polybar_mybar.log & disown
done

echo "Bars launched..."
