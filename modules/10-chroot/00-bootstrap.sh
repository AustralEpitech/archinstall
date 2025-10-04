#!/bin/bash
#shellcheck disable=SC2154

ln -sf "/usr/share/zoneinfo/$tz" /etc/localtime
hwclock --systohc

sed -Ei "/^#($locales)\.UTF-8/s/#//" /etc/locale.gen
locale-gen
echo "LANG=$lang.UTF-8" > /etc/locale.conf

echo "$hostname" > /etc/hostname
