#!/bin/bash -ex

pac "${pkg[@]}" flatpak xdg-desktop-portal-gtk mesa
flatpak install -y "${flatpakpkg[@]}"

case "$(lspci | grep 'VGA\|3D')" in
    *AMD*)    pac vulkan-radeon ;;
    *Intel*)  pac vulkan-intel ;;
    *NVIDIA*) pac vulkan-nouveau ;;
    *) ;;
esac

xdg-user-dirs-update
