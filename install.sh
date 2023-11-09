#!/bin/bash -ex
cd "$(dirname "$0")"
. ./config
. ./src/lib.sh

(
    case "$swapfile" in
        [0-9]*)
            size="$swapfile"
            ;;
        true)
            ram="$(free -h | awk '$1 == "Mem:" {print $2}')"
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

cp -f rootfs/etc/pacman.conf /etc/pacman.conf
systemctl restart reflector
pacman -Sy
pacstrap -K --needed /mnt/ "${pkg[@]}"
cp -rfT rootfs/ /mnt/
genfstab -U /mnt/ >> /mnt/etc/fstab

arch-chroot /mnt/ bash -ex \
    < config               \
    < src/lib.sh           \
    < src/install.sh
