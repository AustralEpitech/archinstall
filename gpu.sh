#!/bin/bash -e
cd "$(dirname "$0")"

NORMAL='\e[0m'
BOLD='\e[1m'
GREEN='\e[32m'

PACMAN='pacman --noconfirm --needed -Syu'

if [ "$EUID" = 0 ]; then
    echo 'This script needs root privileges.'
    exit 1
fi

case "$(lspci -k | grep -E '(VGA|3D)')" in
    *NVIDIA*)
        $PACMAN nvidia{,-utils,-settings}
        mkdir -p /etc/pacman.d/hooks/
        cp nvidia.hook /etc/pacman.d/hooks/
        modules='nvidia nvidia_modeset nvidia_uvm nvidia_drm'
        ;;
    *AMD*)
        $PACMAN mesa vulkan-radeon
        modules=amdgpu
        ;;
    *Intel*)
        $PACMAN mesa vulkan-intel
        modules=i915
        ;;
esac

sed -i "s/^MODULES=(/MODULES=($modules/" /etc/mkinitcpio.conf

mkinitcpio -P

echo -e "${BOLD}${GREEN}GPU drivers install finished.${NORMAL}"
