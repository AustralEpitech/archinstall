#!/bin/bash
#shellcheck disable=SC2154

{
if ls /sys/class/power_supply/BAT* &> /dev/null; then
    printf '%s\n' tlp
fi

printf '%s\n' \
    archlinux-keyring pacman \
    efibootmgr sbctl \
    linux{,-lts,-firmware} \
    mkinitcpio

case "$(lscpu)" in
    *AMD*)   printf '%s\n' amd-ucode   ;;
    *Intel*) printf '%s\n' intel-ucode ;;
esac
case "$(lspci | grep 'VGA\|3D')" in
    *AMD*)    printf '%s\n' vulkan-radeon mesa ;;
    *Intel*)  printf '%s\n' vulkan-intel intel-media-driver ;;
    *NVIDIA*) printf '%s\n' vulkan-nouveau mesa ;;
esac

printf '%s\n' "$shell"
} >> pkglist.txt

pacstrap -C rootfs/etc/pacman.conf -K /mnt - < pkglist.txt

find /mnt/etc/ -name '*.pacnew' -delete
