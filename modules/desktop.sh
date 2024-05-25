#!/bin/bash
#shellcheck disable=SC2154

#newsraft
printf '%s\n' \
    aerc w3m \
    bluez{,-utils} \
    dunst libnotify \
    feh \
    gammastep \
    graphicsmagick ghostscript \
    gvfs{,-gphoto2,-mtp} \
    materia-gtk-theme papirus-icon-theme \
    monero \
    mpv \
    noto-fonts{,-cjk,-emoji} ttf-{dejavu,liberation} otf-font-awesome \
    pass{,-otp} gcr \
    pcmanfm-gtk3 \
    pipewire{,-pulse,-jack} pavucontrol playerctl \
    polkit-gnome \
    qemu-{base,audio-pipewire,hw-usb-host,hw-display-virtio-{gpu,vga},ui-gtk} dnsmasq \
    xdg-user-dirs \
    yt-dlp \
    zathura{,-pdf-poppler} \
    zenity \
        >> pkglist.txt

printf '%s\n' \
    com.valvesoftware.Steam org.freedesktop.Platform.VulkanLayer.gamescope \
    net.lutris.Lutris \
    org.gimp.GIMP \
    org.gtk.Gtk3theme.Materia-dark \
    org.mozilla.firefox \
        >> flatpak.txt

case "$(lspci | grep 'VGA\|3D')" in
       *AMD*) echo vulkan-radeon >> pkglist.txt ;;
     *Intel*) echo vulkan-intel >> pkglist.txt ;;
    *NVIDIA*) echo vulkan-nouveau >> pkglist.txt ;;
           *) ;;
esac

find ./modules/ -name '*.sh.desktop' -exec rename '.desktop' '' '{}' +
bash ./modules/base.sh
