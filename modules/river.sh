#!/bin/sh

printf '%s\n' \
    bemenu-wayland pinentry-bemenu \
    river \
    swayidle swaylock \
    wl-clipboard wtype \
    wlr-randr swaybg \
        >> pkglist.txt

find ./modules/ -name '*.sh.river' -exec rename '.river' '' '{}' +
sh ./modules/desktop.sh
