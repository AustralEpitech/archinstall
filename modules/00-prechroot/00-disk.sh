#!/bin/sh
#shellcheck disable=SC2154

sgdisk -Z \
    -n '0:0:+512M' -t '0:ef00' -c '0:esp' \
    -n '0:0:0'     -t '0:8300' -c '0:root' \
    "$disk"

esp=/dev/disk/by-partlabel/esp
root=/dev/disk/by-partlabel/root

if [ -n "$disk_passwd" ]; then
    printf '%s' "$disk_passwd" | cryptsetup luksFormat "$root" -
    printf '%s' "$disk_passwd" | cryptsetup open "$root" root -
    root=/dev/mapper/root
fi

while ! [ -e "$root" ] || ! [ -e "$esp" ]; do
    echo 'waiting for /dev/disk/by-partlabel/ to be populated' >&2
    sleep 1
done

mkfs.vfat -F32 "$esp"
mkfs.ext4 -F "$root"
mount "$root" /mnt/
mount -m "$esp" /mnt/efi/

mkdir -p /mnt/etc/ /mnt/efi/EFI/Linux/

cat <<EOF > /mnt/etc/fstab
UUID=$(blkid "$root" -ovalue -sUUID)	/	ext4	rw,relatime	0 1
UUID=$(blkid "$esp" -ovalue -sUUID)	/efi	vfat	rw,umask=0077	0 2
EOF

if [ -n "$swapfile" ]; then
    dd if=/dev/zero of=/mnt/swapfile bs=1M count="$swapfile" status=progress
    chmod 0600 /mnt/swapfile
    mkswap /mnt/swapfile
    echo "/swapfile	none	swap	defaults	0 0" >> /mnt/etc/fstab
fi

cp -rfTv rootfs/ /mnt/
