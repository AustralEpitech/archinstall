#!/bin/bash
#shellcheck disable=SC2154

ln -sf "/usr/share/zoneinfo/$tz" /etc/localtime
hwclock --systohc

for l in "${locales[@]}"; do
    sed -i "/^#\s*$l.UTF-8/s/^#\s*//" /etc/locale.gen
done
locale-gen

echo "LANG=$lang.UTF-8" > /etc/locale.conf

echo - "$hostname" > /etc/hostname
