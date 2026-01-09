#!/bin/sh

root="$(findmnt -n -osource /)"
esp="$(findmnt -n -osource /efi/)"

{
cryptdev="$(cryptsetup status "$root" | awk '/device/{print $2}')"
if [ -n "$cryptdev" ]; then
    echo "rd.luks.name=$(lsblk -ndo uuid "$cryptdev")=$(basename "$root") "
fi

echo "root=$root init=/lib/systemd/systemd rw"
} > /etc/cmdline.d/root.conf

sbctl create-keys
sbctl enroll-keys --yolo
mkinitcpio -P

for l in arch-linux arch-linux-lts-fallback; do
    efibootmgr --create --unicode --label "$l" \
        --disk "$esp" --loader "\\EFI\\Linux\\$l.efi"
done
