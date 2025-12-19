#!/bin/sh

#newsraft
printf '%s\n' \
    aerc w3m \
    alacritty \
    bluez bluez-utils \
    feh \
    firefox firefox-ublock-origin firefox-noscript \
    gammastep \
    imagemagick ghostscript \
    monero \
    mpv \
    noto-fonts noto-fonts-cjk noto-fonts-emoji otf-font-awesome \
    pass pass-otp \
    pipewire-jack playerctl rtkit \
    qemu-base qemu-hw-usb-host qemu-hw-display-qxl qemu-ui-gtk dnsmasq usbutils \
    xdg-utils xdg-user-dirs \
    yt-dlp \
    zathura-pdf-poppler \
        >> pkglist.txt

find ./modules/ -name '*.sh.desktop' -exec rename '.desktop' '' '{}' +
sh ./modules/base.sh
