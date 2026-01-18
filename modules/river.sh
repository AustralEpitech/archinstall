#!/bin/sh

printf '%s\n' \
    bemenu-wayland pinentry-bemenu \
    foot \
    grim slurp \
    imv \
    river \
    swaybg \
    swayidle swaylock \
    wl-clipboard \
    wlopm \
    wlr-randr \
    wlsunset \
    wtype \
    xdg-desktop-portal-wlr \
        >> pkglist.txt

find ./modules/ -name '*.sh.river' -exec rename '.river' '' '{}' +
sh ./modules/desktop.sh
