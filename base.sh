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
$PACMAN "${pkg[@]}"
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

case "$(lscpu | grep Vendor)" in
    *AuthenticAMD*)
        $PACMAN amd-ucode
        ;;
    *GenuineIntel*)
        $PACMAN intel-ucode
        ;;
esac
./gpu.sh

# Bootloader
sed -i '/GRUB_DISABLE_OS_PROBER=/s/.*/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub

if [ -n "$grub_timeout" ]; then
    sed -i "/GRUB_TIMEOUT=/s/.*/GRUB_TIMEOUT=$grub_timeout/" /etc/default/grub
fi

grub-install --target=x86_64-efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

echo -e "${BOLD}${GREEN}DONE. You can install a desktop environment \
(see README.md). Then, you can Ctrl+D, umount -R /mnt and reboot${NORMAL}"
