#!/bin/bash

{
printf '%s\n' \
    i3lock xss-lock \
    picom \
    xorg-{server,xinit,xrandr,xsetroot} xclip xdotool

case "$(lsmod)" in
    *amdgpu*) printf '%s\n' xf86-video-amdgpu ;;
    *nouveau*) printf '%s\n' xf86-video-nouveau ;;

    # https://wiki.archlinux.org/title/Intel_graphics#Installation
    #*i915*) printf '%s\n' xf86-video-intel ;;
esac
} >> pkglist.txt

find ./modules/ -name '*.sh.dwm' -exec rename '.dwm' '' '{}' +
bash ./modules/desktop.sh
