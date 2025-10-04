#!/bin/bash

root="$(findmnt -n -osource /)"
esp="$(lsblk -ls -opath /dev/disk/by-partlabel/esp | tail -n1)"

cryptdev="$(cryptsetup status "$root" | awk '/device/ {print $2}')"
if [ -n "$cryptdev" ]; then
    uuid="$(blkid | grep "$cryptdev" | awk '{print $2}')"
    options="cryptdevice=$uuid:${root##*/} "
fi

options="${options}root=$root rw"

sbctl create-keys
sbctl enroll-keys --yolo
mkinitcpio -P

for l in arch-linux{,-lts-fallback}; do
    efibootmgr --create --unicode --label "$l" \
        --disk "$esp" --part 1 --loader "\\EFI\\Linux\\$l.efi"
done
echo "$options" > /etc/cmdline.d/root.conf
