#!/bin/bash
#shellcheck disable=SC2154

case "$(lscpu)" in
    *AMD*)   printf '%s\n' amd-ucode   >> pkglist.txt ;;
    *Intel*) printf '%s\n' intel-ucode >> pkglist.txt ;;
esac

if [ -d /sys/class/power_supply/BAT0 ]; then
    printf '%s\n' tlp >> pkglist.txt
fi

printf '%s\n' "$shell" >> pkglist.txt
pacstrap -C rootfs/etc/pacman.conf -K /mnt \
    linux{,-lts,-firmware} efibootmgr sbctl pacman archlinux-keyring - < pkglist.txt

find /mnt/etc/ -name '*.pacnew' -delete
