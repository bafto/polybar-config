#!/bin/bash

# Get current profile, cycle to next on click
PROFILES=("power-saver" "balanced" "performance")
ICONS=("󰌪" "󰾅" "󰓅")   # nerd font icons; or use text like [PS] [B] [P]

CURRENT=$(powerprofilesctl get)

case "$1" in
  cycle)
    for i in "${!PROFILES[@]}"; do
      if [[ "${PROFILES[$i]}" == "$CURRENT" ]]; then
        NEXT=$(( (i + 1) % ${#PROFILES[@]} ))
        powerprofilesctl set "${PROFILES[$NEXT]}"
        exit 0
      fi
    done
    ;;
  *)
    # Display current profile with icon
    for i in "${!PROFILES[@]}"; do
      if [[ "${PROFILES[$i]}" == "$CURRENT" ]]; then
        echo "${ICONS[$i]} $CURRENT"
        exit 0
      fi
    done
    ;;
esac
