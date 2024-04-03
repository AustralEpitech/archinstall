#!/bin/bash -ex
cd "$(dirname "$0")"
. ./config
. ./src/lib.sh

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
cp -rfT rootfs/ /mnt/
genfstab -U /mnt/ >> /mnt/etc/fstab

cat config src/lib.sh src/install.sh | arch-chroot /mnt/ bash -ex

echo "${BOLD}${GREEN}DONE${NORMAL}"
