#!/bin/bash

if ! sbctl status | grep -q '^Setup Mode:.*Enabled$'; then
    printf '%s\n' \
        'If you want Secure Boot support, you need to put your system in Setup Mode' \
        'See https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot'
    read -rp "Reboot into the firmware setup interface? [Y/n] " ANS
    if ! [[ "${ANS,}" =~ ^$|^y ]]; then
        systemctl reboot --firmware-setup
    fi
fi

exec &> >(tee logs.out)

set -a
. ./config
set +a

printf '%s\n' "${pkg[@]}" > pkglist.txt

bash ./modules/"$install_type".sh
