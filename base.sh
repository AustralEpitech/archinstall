#!/bin/bash -e
cd "$(dirname "$0")"
. ./config

NORMAL='\e[0m'
BOLD='\e[1m'
GREEN='\e[32m'

PACMAN='pacman --noconfirm --needed -Syu'

# System config
cp -rfT rootfs/ /
ln -sf "/usr/share/zoneinfo/$tz" /etc/localtime
hwclock --systohc
for l in "${locales[@]}"; do
    sed -i "/#\s*$l.UTF-8/s/^#\s*//" /etc/locale.gen
done
locale-gen
echo "LANG=$lang.UTF-8" > /etc/locale.conf
echo "$hostname" > /etc/hostname

# Packages
case "$(lscpu | grep Vendor)" in
    *AuthenticAMD*)
        cpu=amd
        ;;
    *GenuineIntel*)
        cpu=intel
        ;;
esac

$PACMAN "${pkg[@]}" "$cpu-ucode"
systemctl enable    \
    NetworkManager  \
    docker.socket   \
    reflector.timer \
    systemd-timesyncd

if ls -d /sys/class/power_supply/BAT*/ > /dev/null 2>&1; then
    $PACMAN "${laptop_pkg[@]}"
    systemctl enable tlp
fi

# Users
echo "root:$root_passwd" | chpasswd
useradd -mG wheel "$username"
echo "$username:$user_passwd" | chpasswd

sed -i '/^# %wheel\s\+ALL=(ALL:ALL)\s\+ALL/s/^#\s*//' /etc/sudoers

# drivers
sed -i '/^HOOKS=(/s/filesystems/encrypt filesystems/' /etc/mkinitcpio.conf

./gpu.sh

# Bootloader
bootctl install

root="$(findmnt -nr -o source /)"
cryptdev="$(cryptsetup status "$root" | grep device | awk '{print $2}' || true)"
if "$cryptdev"; then
    uuid="$(blkid | grep /dev/nvme0n1p2 | awk '{print $2}')"
    options="cryptdevice=$uuid:$(basename "$root") "
fi

options="${options}root=$root"

find /boot/loader/entries/ | while read -r e; do
    echo "options $options rw" >> "$e"
done

echo -e "${BOLD}${GREEN}DONE. You can install a desktop environment \
(see README.md). Then, you can Ctrl+D, umount -R /mnt and reboot${NORMAL}"
