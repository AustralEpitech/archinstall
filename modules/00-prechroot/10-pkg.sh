#!/bin/bash
#shellcheck disable=SC2154

if ls /sys/class/power_supply/BAT* &> /dev/null; then
    printf '%s\n' tlp >> pkglist.txt
fi

cat <<EOF >> pkglist.txt
    archlinux-keyring
    efibootmgr
    linux{,-lts,-firmware}
    mkinitcpio
    pacman
    sbctl
EOF

case "$(lscpu)" in
    *AMD*)   printf '%s\n' amd-ucode   ;;
    *Intel*) printf '%s\n' intel-ucode ;;
esac >> pkglist.txt
case "$(lspci | grep 'VGA\|3D')" in
    *AMD*)    printf '%s\n' vulkan-radeon mesa ;;
    *Intel*)  printf '%s\n' vulkan-intel intel-media-driver ;;
    *NVIDIA*) printf '%s\n' vulkan-nouveau mesa ;;
esac >> pkglist.txt

printf '%s\n' "$shell" >> pkglist.txt
pacstrap -C rootfs/etc/pacman.conf -K /mnt - < pkglist.txt

find /mnt/etc/ -name '*.pacnew' -delete
