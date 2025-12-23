#!/bin/sh

printf '%s\n' \
    bemenu-wayland pinentry-bemenu \
    foot \
    river \
    swayidle swaylock \
    wl-clipboard wtype \
    wlr-randr swaybg wlsunset \
    xdg-desktop-portal-wlr \
        >> pkglist.txt

find ./modules/ -name '*.sh.river' -exec rename '.river' '' '{}' +
sh ./modules/desktop.sh
