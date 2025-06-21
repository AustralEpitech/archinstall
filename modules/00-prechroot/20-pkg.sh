#!/bin/bash
#shellcheck disable=SC2154

case "$(lscpu)" in
    *AMD*)   echo amd-ucode   >> pkglist.txt ;;
    *Intel*) echo intel-ucode >> pkglist.txt ;;
    *) ;;
esac

if [ -d /sys/class/power_supply/BAT0 ]; then
    echo tlp >> pkglist.txt
fi

echo "$shell" >> pkglist.txt
pacstrap -C rootfs/etc/pacman.conf -K /mnt \
    base linux{,-lts,-firmware} efibootmgr sbctl - < pkglist.txt

find /mnt/etc/ -name '*.pacnew' -delete
