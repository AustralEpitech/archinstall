#!/bin/bash
#shellcheck disable=SC2154

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
    pipewire{-pulse,-jack} playerctl \
    polkit-gnome \
    qemu-{base,audio-pipewire,hw-usb-host,hw-display-virtio-{gpu,vga},ui-gtk} dnsmasq usbutils \
    udisks2 \
    xdg-utils xdg-user-dirs \
    yt-dlp \
    zathura-pdf-poppler \
    zenity \
        >> pkglist.txt

case "$(lspci | grep 'VGA\|3D')" in
    *AMD*)    echo vulkan-radeon mesa >> pkglist.txt ;;
    *Intel*)  echo vulkan-intel intel-media-driver >> pkglist.txt ;;
    *NVIDIA*) echo vulkan-nouveau mesa >> pkglist.txt ;;
    *) ;;
esac

find ./modules/ -name '*.sh.desktop' -exec rename '.desktop' '' '{}' +
bash ./modules/base.sh
