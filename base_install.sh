#!/bin/bash -e
cd "$(dirname "$0")"
. ./config

NORMAL='\e[0m'
BOLD='\e[1m'
GREEN='\e[32m'

PACMAN='pacman --needed -Syu'

# System config
ln -sf "/usr/share/zoneinfo/$tz" /etc/localtime
hwclock --systohc
timedatectl set-ntp true
for l in "${locales[@]}"; do
    sed -i "/#\s*$l/s/^#\s*//" /etc/locale.gen # todo test
done
locale-gen
echo "LANG=$lang" > /etc/locale.conf
echo "$hostname" > /etc/hostname

# Packages
cp -rf rootfs/ /
$PACMAN "${pkg[@]}"
systemctl enable NetworkManager
systemctl enable reflector.timer

if [ -d /sys/module/battery/ ]; then
    $PACMAN "${laptop_pkg[@]}"
    systemctl enable tlp
fi

# Users
echo "root:$root_passwd" | chpasswd
useradd -mG wheel "$username"
echo "$username:$user_passwd" | chpasswd

sed -i '/%wheel\s\+ALL=(ALL)\s\+ALL/s/^#\s*//' /etc/sudoers

# Bootloader
case "$(lscpu | grep Vendor)" in
    *AuthenticAMD*)
        $PACMAN amd-ucode
        ;;
    *GenuineIntel*)
        $PACMAN intel-ucode
        ;;
esac

bootctl install
cp loader/ /boot/loader # TODO

mkinitcpio -P

echo -e "${BOLD}${GREEN}DONE. Ctrl+D, umount -R /mnt and reboot${NORMAL}"
