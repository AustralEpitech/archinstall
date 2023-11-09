#!/bin/bash -e
cd "$(dirname "$0")"
. ./config
. ./lib.sh

(
    case "$swapfile" in
        [0-9]*)
            size=$swapfile
            ;;
        true)
            size="$(python -c "from math import ceil,log; print(2**ceil((log($swapfile)/log(2))))")"
            ;;
        *)
            exit
            ;;
    esac

    dd if=/dev/zero of=/mnt/swapfile bs=1M count="$swapfile" status=progress
    chmod 600 /mnt/swapfile
    mkswap /mnt/swapfile
    swapon /mnt/swapfile
)

cp -f rootfs/etc/pacman.conf /etc/pacman.conf
systemctl restart reflector
pacman -Sy
pacstrap -K /mnt/ "${pkg[@]}"
cp -rfT rootfs/ /mnt/
genfstab -U /mnt >> /mnt/etc/fstab
cat base.sh | arch-chroot /mnt/ bash
