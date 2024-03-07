#!/bin/bash -ex

# System config
ln -sf "/usr/share/zoneinfo/$tz" /etc/localtime
hwclock --systohc
for l in "${locales[@]}"; do
    sed -i "/^#\s*$l.UTF-8/s/^#\s*//" /etc/locale.gen
done
locale-gen
echo "LANG=$lang.UTF-8" > /etc/locale.conf
echo "$hostname" > /etc/hostname

sed -i '/^HOOKS=(/s/filesystems/encrypt filesystems/' /etc/mkinitcpio.conf

# Services
systemctl enable \
    NetworkManager \
    ip6tables \
    iptables \
    reflector.timer \
    systemd-resolved \
    systemd-timesyncd \
    tlp

# Users
echo "root:$root_passwd" | chpasswd
useradd -mG wheel,video "$username" -s "${default_shell-/bin/bash}"
echo "$username:$user_passwd" | chpasswd
su "$username" -c 'xdg-user-dirs-update' 2> /dev/null || true

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
options $options rw
EOF
done
