#!/bin/bash
#shellcheck disable=SC2154

printf '%s\n' \
    i3lock xss-lock \
    picom \
    xorg-{server,xinit,xrandr,xsetroot} xclip xdotool \
        >> pkglist.txt

case "$(lsmod)" in
    *amdgpu*) echo xf86-video-amdgpu >> pkglist.txt ;;
    *i915*)
        # https://wiki.archlinux.org/title/Intel_graphics#Installation
        #echo xf86-video-intel >> pkglist.txt
        ;;
    *nouveau*)
        # https://bugs.freedesktop.org/show_bug.cgi?id=94844#c3
        #echo xf86-video-nouveau >> pkglist.txt
        ;;
    *)
        ;;
esac

find ./modules/ -name '*.sh.dwm' -exec rename '.dwm' '' '{}' +
bash ./modules/desktop.sh
