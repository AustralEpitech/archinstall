#!/bin/bash -e
cd "$(dirname "$0")"
. ./config

if [ -t 1 ]; then
    NORMAL='\e[0m'
    BOLD='\e[1m'
    GREEN='\e[32m'
fi

PACMAN='pacman --noconfirm --needed -Syu'

# System config
cp -rfT rootfs/ /
ln -sf "/usr/share/zoneinfo/$tz" /etc/localtime
hwclock --systohc
for l in "${locales[@]}"; do
    sed -i "/^#\s*$l.UTF-8/s/^#\s*//" /etc/locale.gen
done
locale-gen
echo "LANG=$lang.UTF-8" > /etc/locale.conf
echo "$hostname" > /etc/hostname

# Drivers
case "$(lscpu | grep Vendor)" in
    *AuthenticAMD*) cpu=amd   ;;
    *GenuineIntel*) cpu=intel ;;
esac
sed -i '/^HOOKS=(/s/filesystems/encrypt filesystems/' /etc/mkinitcpio.conf

# Packages
$PACMAN "${pkg[@]}" "$cpu-ucode"
systemctl enable      \
    NetworkManager    \
    podman.socket     \
    reflector.timer   \
    systemd-resolved  \
    systemd-timesyncd

if ls -d /sys/class/power_supply/BAT*/ > /dev/null 2>&1; then
    $PACMAN "${laptop_pkg[@]}"
    systemctl enable tlp
fi

# Users
echo "root:$root_passwd" | chpasswd
useradd -mG wheel,video "$username" -s "${default_shell-/bin/bash}"
echo "$username:$user_passwd" | chpasswd
su "$username" -c 'xdg-user-dirs-update' 2> /dev/null || true

sed -i '/^#\s*%wheel\s\+ALL=(ALL:ALL)\s\+ALL/s/^#\s*//' /etc/sudoers

# Bootloader
bootctl install

root="$(findmnt -nr -o source /)"
cryptdev="$(cryptsetup status "$root" | grep device | awk '{print $2}' || true)"
if [ -n "$cryptdev" ]; then
    uuid="$(blkid | grep "$cryptdev" | awk '{print $2}')"
    options="cryptdevice=$uuid:$(basename "$root") "
fi

options="${options}root=$root"

for f in /boot/loader/entries/*.conf; do
    cat << EOF >> "$f"
initrd  /$cpu-ucode.img
options $options rw
EOF
done

echo -e "${BOLD}${GREEN}DONE. You can install a desktop environment \
(see README.md). Then, you can Ctrl+D, umount -R /mnt and reboot${NORMAL}"
