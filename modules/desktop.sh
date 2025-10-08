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

case "$(lspci | grep 'VGA\|3D')" in
    *AMD*)    printf '%s\n' vulkan-radeon mesa >> pkglist.txt ;;
    *Intel*)  printf '%s\n' vulkan-intel intel-media-driver >> pkglist.txt ;;
    *NVIDIA*) printf '%s\n' vulkan-nouveau mesa >> pkglist.txt ;;
    *) ;;
esac

find ./modules/ -name '*.sh.desktop' -exec rename '.desktop' '' '{}' +
bash ./modules/base.sh
