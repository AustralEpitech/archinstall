#!/bin/bash
cd -- "$(dirname "$0")"
. ./config
. ./src/lib.sh

set -x
(
    case "$swapfile" in
        [0-9]*)
            size="$swapfile"
            ;;
        auto)
            ram="$(free -m | awk '/^Mem:/ {print $2}')"
            size="$(python -c "from math import ceil,log; print(2**ceil((log($ram)/log(2))))")"
            ;;
        *)
            exit
            ;;
    esac

    dd if=/dev/zero of=/mnt/swapfile bs=1M count="$size" status=progress
    chmod 600 /mnt/swapfile
    mkswap /mnt/swapfile
    swapon /mnt/swapfile
)

pacstrap -C rootfs/etc/pacman.conf -K /mnt/ --needed "${pkg[@]}"
cp -rfTv rootfs/ /mnt/
genfstab -U /mnt/ >> /mnt/etc/fstab
swapoff /mnt/swapfile

cat config src/lib.sh src/install.sh | arch-chroot /mnt/ bash

echo "${BOLD}${GREEN}DONE${NORMAL}"
