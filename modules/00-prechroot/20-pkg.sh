#!/bin/bash
#shellcheck disable=SC2154

case "$(lscpu)" in
    *AMD*)   echo amd-ucode   >> pkglist.txt ;;
    *Intel*) echo intel-ucode >> pkglist.txt ;;
    *) ;;
esac

[ -s modules/chroot/flatpak.txt ] \
    && printf '%s\n' flatpak xdg-desktop-portal-gtk >> pkglist.txt

[ -d /sys/class/power_supply/BAT0 ] && echo tlp >> pkglist.txt

pacstrap -C rootfs/etc/pacman.conf -K /mnt \
    base linux{,-lts,-firmware} "$shell" efibootmgr sbctl - < pkglist.txt

find /mnt/etc/ -name '*.pacnew' -delete
