#!/bin/bash
#shellcheck disable=SC2154

sgdisk -Z \
    -n '0:0:+512M' -t '0:ef00' -c '0:boot' \
    -n '0:0:0'     -t '0:8300' -c '0:root' \
    "$disk"

boot=/dev/disk/by-partlabel/boot
root=/dev/disk/by-partlabel/root

[ -n "$disk_passwd" ] && {
    echo -n "$disk_passwd" | cryptsetup luksFormat "$root" -
    cryptsetup open "$root" cryptroot - <<< "$disk_passwd"
    root=/dev/mapper/cryptroot
}

sleep 2 # wait for /dev/disk/by-partlabel/ to be populated

mkfs.fat -F32 "$boot"
mkfs.ext4 -F "$root"
mount "$root" /mnt/
mount -m -o fmask=0077,dmask=0077 /dev/disk/by-partlabel/boot /mnt/boot/

[ -n "$swapfile" ] && {
    dd if=/dev/zero of=/mnt/swapfile bs=1M count="$swapfile" status=progress
    chmod 600 /mnt/swapfile
    mkswap /mnt/swapfile
    swapon /mnt/swapfile
}

cp -rfTv rootfs/ /mnt/
genfstab -U /mnt/ >> /mnt/etc/fstab
swapoff /mnt/swapfile
