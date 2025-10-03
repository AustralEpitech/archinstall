#!/bin/bash

printf '%s\n' \
    i3lock xss-lock \
    picom \
    xorg-{server,xinit,xrandr,xsetroot} xclip xdotool \
        >> pkglist.txt

case "$(lsmod)" in
    *amdgpu*) printf '%s\n' xf86-video-amdgpu >> pkglist.txt ;;

    # https://wiki.archlinux.org/title/Intel_graphics#Installation
    #*i915*) printf '%s\n' xf86-video-intel >> pkglist.txt ;;

    # https://bugs.freedesktop.org/show_bug.cgi?id=94844#c3
    #*nouveau*) printf '%s\n' xf86-video-nouveau >> pkglist.txt ;;
esac

find ./modules/ -name '*.sh.dwm' -exec rename '.dwm' '' '{}' +
bash ./modules/desktop.sh
