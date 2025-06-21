#!/bin/bash
#shellcheck disable=SC2154

sgdisk -Z \
    -n '0:0:+512M' -t '0:ef00' -c '0:esp' \
    -n '0:0:0'     -t '0:8300' -c '0:root' \
    "$disk"

esp=/dev/disk/by-partlabel/esp
root=/dev/disk/by-partlabel/root

if [ -n "$disk_passwd" ]; then
    echo -n "$disk_passwd" | cryptsetup luksFormat "$root" -
    cryptsetup open "$root" cryptroot - <<< "$disk_passwd"
    root=/dev/mapper/cryptroot
fi

sleep 5 # wait /dev/disk/by-partlabel/

mkfs.vfat -F32 "$esp"
mkfs.ext4 -F "$root"
mount "$root" /mnt/

cat <<EOF > /mnt/etc/fstab
UUID=$(blkid "$root" -ovalue -sUUID)	/	ext4	rw,relatime	0 1
UUID=$(blkid "$esp" -ovalue -sUUID)	/efi	vfat	rw,fmask=0077,dmask=0077,noauto	0 2
EOF

if [ -n "$swapfile" ]; then
    dd if=/dev/zero of=/mnt/swapfile bs=1M count="$swapfile" status=progress
    chmod 600 /mnt/swapfile
    mkswap /mnt/swapfile
    swapon /mnt/swapfile
    echo "/swapfile	none	swap	defaults	0 0" >> /mnt/etc/fstab
fi

cp -rfTv rootfs/ /mnt/

swapoff /mnt/swapfile
