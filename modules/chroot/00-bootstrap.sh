#!/bin/bash
#shellcheck disable=SC2154

ln -sf "/usr/share/zoneinfo/$tz" /etc/localtime
hwclock --systohc

while read -r l; do
    sed -i "/^#\s*$l.UTF-8/s/^#\s*//" /etc/locale.gen
done < <(sed 's/,/\n/g' "$locales")
locale-gen

echo "LANG=$lang.UTF-8" > /etc/locale.conf

echo "$hostname" > /etc/hostname
