#!/bin/bash
#shellcheck disable=SC2154

pkg+=(
    autorandr
    i3lock xss-lock
    picom
    xorg-{server,xinit,xrandr,xsetroot} xclip xdotool
)

case "$(lsmod)" in
    *amdgpu*) pkg+=(xf86-video-amdgpu) ;;
    *i915*)
        # https://wiki.archlinux.org/title/Intel_graphics#Installation
        #pkg+=(xf86-video-intel)
        ;;
    *nouveau*)
        # https://bugs.freedesktop.org/show_bug.cgi?id=94844#c3
        #pkg+=(xf86-video-nouveau)
        ;;
    *)
        ;;
esac

./modules/desktop.sh

git clone --depth 1 https://git.maby.dev/ange/.dotfiles.git dotfiles
arch-chroot ./dotfiles/.config/suckless/update.sh
