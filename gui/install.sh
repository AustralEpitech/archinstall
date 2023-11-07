#!/bin/bash -e
cd "$(dirname "$0")"
. ./config

if [ -t 1 ]; then
    NORMAL='\e[0m'
    BOLD='\e[1m'
    GREEN='\e[32m'
fi

PACMAN='pacman --noconfirm --needed -Syu'

if [ "$EUID" != 0 ]; then
    echo 'This script needs root privileges.'
    exit 1
fi

$PACMAN "${pkg[@]}" flatpak
flatpak install "${flatpakpkg[@]}"

case "$(lspci -k | grep -E '(VGA|3D)')" in
    *AMD*)
        $PACMAN mesa vulkan-radeon
        modules=amdgpu
        ;;
    *Intel*)
        $PACMAN mesa vulkan-intel
        modules=i915
        ;;
    *NVIDIA*)
        $PACMAN nvidia{,-utils,-settings}
        modules='nvidia nvidia_modeset nvidia_uvm nvidia_drm'
        ;;
esac

sed -i "s/^MODULES=(/MODULES=($modules/" /etc/mkinitcpio.conf
mkinitcpio -P

xdg-user-dirs-update

echo -e "${BOLD}${GREEN}GPU drivers install finished.${NORMAL}"
