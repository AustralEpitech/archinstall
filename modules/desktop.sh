#!/bin/bash

#newsraft
printf '%s\n' \
    aerc w3m \
    alacritty \
    bluez{,-utils} \
    feh \
    firefox{,-ublock-origin} \
    gammastep \
    imagemagick ghostscript \
    materia-gtk-theme \
    monero \
    mpv \
    noto-fonts{,-cjk,-emoji} otf-font-awesome \
    pass-otp gcr \
    pipewire-jack playerctl rtkit \
    qemu-{base,audio-pipewire,hw-usb-host,qemu-hw-display-qxl,ui-gtk} dnsmasq usbutils \
    udisks2 \
    xdg-utils xdg-user-dirs \
    yt-dlp \
    zathura-pdf-poppler \
        >> pkglist.txt

find ./modules/ -name '*.sh.desktop' -exec rename '.desktop' '' '{}' +
bash ./modules/base.sh
