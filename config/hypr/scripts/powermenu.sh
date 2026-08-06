#!/usr/bin/env bash

entries=" Bloquear\n Suspender\n Reiniciar\n Apagar\n Cerrar sesión"

selected=$(echo -e "$entries" | wofi --dmenu --prompt "Sesión" --width 300 --height 250 --cache-file /dev/null)

case "$selected" in
    *Bloquear*)      hyprlock ;;
    *Suspender*)     systemctl suspend ;;
    *Reiniciar*)     systemctl reboot ;;
    *Apagar*)        systemctl poweroff ;;
    *"Cerrar sesión"*) hyprctl dispatch exit ;;
esac
