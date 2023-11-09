#!/bin/bash -e
cd "$(dirname "$0")"
. ./config
. ../lib.sh

if [ "$EUID" != 0 ]; then
    echo 'This script needs root privileges.'
    exit 1
fi

pac "${pkg[@]}" flatpak
flatpak install -y "${flatpakpkg[@]}"

case "$(lspci -k | grep -E '(VGA|3D)')" in
    *AMD*)
        pac mesa vulkan-radeon
        modules=amdgpu
        ;;
    *Intel*)
        pac mesa vulkan-intel
        modules=i915
        ;;
    *NVIDIA*)
        pac nvidia{,-utils,-settings}
        modules='nvidia nvidia_modeset nvidia_uvm nvidia_drm'
        ;;
esac

sed -i "s/^MODULES=(/MODULES=($modules/" /etc/mkinitcpio.conf
mkinitcpio -P

xdg-user-dirs-update

echo -e "${BOLD}${GREEN}GPU drivers install finished.${NORMAL}"
