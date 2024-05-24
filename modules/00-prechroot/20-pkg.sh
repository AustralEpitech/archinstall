#!/bin/bash
#shellcheck disable=SC2154

case "$(lscpu)" in
    *AMD*)   pkg+=(amd-ucode) ;;
    *Intel*) pkg+=(intel-ucode) ;;
    *) ;;
esac

[ -n "$flatpak" ] && pkg+=(flatpak xdg-desktop-portal-gtk)

[ -f /sys/class/power_supply/BAT0 ] && pkg+=(tlp)

pacstrap -C rootfs/etc/pacman.conf -K /mnt/ \
    base linux{,-lts,-firmware} "$shell" "${pkg[@]}"
