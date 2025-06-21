#!/bin/bash
#shellcheck disable=SC2154

root="$(findmnt -n -osource /)"
boot="$(lsblk -ls -oname /dev/disk/by-partlabel/boot | tail -n1)"

cryptdev="$(cryptsetup status "$root" | awk '/device/ {print $2}')"
if [ -n "$cryptdev" ]; then
    uuid="$(blkid | grep "$cryptdev" | awk '{print $2}')"
    options="cryptdevice=$uuid:${root##*/} "
fi

options="${options}root=$root rw"

sbctl create-keys
sbctl enroll-keys

for l in arch{,-lts-fallback}; do
    efibootmgr --create --unicode --label "$l" \
        --disk "$boot" --part 1 --loader "\\EFI\\Linux\\arch-linux$l.efi"
done
echo "$options" > /etc/cmdline.d/root.conf
