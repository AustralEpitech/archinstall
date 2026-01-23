#!/bin/sh
cd "${0%/*}" || exit 1

pacman --config rootfs/etc/pacman.conf -Sy --noconfirm --needed sbctl

if ! sbctl status | grep -q '^Setup Mode:.*Enabled$'; then
    printf '%s\n' \
        'If you want Secure Boot support, you need to put your system in Setup Mode' \
        'See https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot' \
        'Reboot into the firmware setup interface? [Y/n] ' >&2
    read -r ANS
    if printf %s "$ANS" | grep -qi '^\(y\|$\)'; then
        systemctl reboot --firmware-setup
    fi
fi

{
    . ./config
    sh "./modules/$install_type.sh"
} 2>&1 | tee logs.out
