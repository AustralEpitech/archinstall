#!/bin/bash -ex

pac "${pkg[@]}" flatpak xdg-desktop-portal-gtk mesa
flatpak install -y "${flatpakpkg[@]}"

case "$(lspci -k | grep -E '(VGA|3D)')" in
    *AMD*)
        pac vulkan-radeon
        modules=amdgpu
        ;;
    *Intel*)
        pac vulkan-intel
        modules=i915
        ;;
    *NVIDIA*)
        #pac vulkan-nvk
        modules=nouveau
        ;;
esac

sed -i "/^MODULES=(/s/)/$modules)/" /etc/mkinitcpio.conf
mkinitcpio -P

xdg-user-dirs-update
