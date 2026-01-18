#!/bin/sh

#newsraft
printf '%s\n' \
    aerc w3m \
    bluez bluez-utils \
    firefox firefox-noscript firefox-ublock-origin \
    imagemagick ghostscript \
    monero \
    mpv-mpris \
    noto-fonts noto-fonts-cjk noto-fonts-emoji otf-font-awesome \
    pass \
    pipewire-jack rtkit \
    qemu-base qemu-chardev-spice qemu-hw-display-qxl qemu-hw-usb-host dnsmasq spice-gtk \
    usbutils \
    xdg-user-dirs \
    xdg-utils \
    yt-dlp \
    zathura-pdf-poppler \
        >> pkglist.txt

find ./modules/ -name '*.sh.desktop' -exec rename '.desktop' '' '{}' +
sh ./modules/base.sh
