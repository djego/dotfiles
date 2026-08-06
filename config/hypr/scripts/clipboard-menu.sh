#!/usr/bin/env bash

cliphist list | wofi --dmenu --prompt "Portapapeles" --width 600 --height 400 --cache-file /dev/null | cliphist decode | wl-copy
