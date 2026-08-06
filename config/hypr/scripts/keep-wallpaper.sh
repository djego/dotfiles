#!/usr/bin/env bash
set -euo pipefail

CONFIG="$HOME/.config/waypaper/config.ini"
SELECTED_DIR="$HOME/Pictures/Wallpapers/selected"
mkdir -p "$SELECTED_DIR"

wallpaper=$(python3 -c "
import configparser, pathlib
cf = configparser.ConfigParser()
cf.read(pathlib.Path('$CONFIG').expanduser())
raw = cf.get('Settings', 'wallpaper', fallback='')
first = raw.split(chr(10))[0].strip()
print(str(pathlib.Path(first).expanduser())) if first else print('')
")

if [[ -z "$wallpaper" || ! -f "$wallpaper" ]]; then
    notify-send "Wallpapers" "No se pudo detectar el wallpaper actual"
    exit 1
fi

dest="$SELECTED_DIR/$(basename "$wallpaper")"
if [[ -e "$dest" ]]; then
    notify-send "Wallpapers" "Ya estaba guardado: $(basename "$wallpaper")"
else
    cp "$wallpaper" "$dest"
fi

count=$(find "$SELECTED_DIR" -maxdepth 1 -type f | wc -l)
notify-send "Wallpaper guardado" "$(basename "$wallpaper") ($count en selected/)"
