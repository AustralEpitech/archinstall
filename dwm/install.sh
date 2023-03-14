#!/bin/bash -e
cd "$(dirname "$0")"
. ./config

NORMAL='\e[0m'
BOLD='\e[1m'
GREEN='\e[32m'

PACMAN='pacman --noconfirm --needed -Syu'

if [ "$EUID" = 0 ]; then
    echo 'This script needs root privileges.'
    exit 1
fi

# drivers
case "$(lspci -k | grep -A3 -E '(VGA|3D)')" in
    *amdgpu*)
        pkg=("${pkg[@]}" xf86-video-amdgpu)
        ;;
    *i915*)
        pkg=("${pkg[@]}" xf86-video-intel)
        ;;
    *nouveau*)
        pkg=("${pkg[@]}" xf86-video-nouveau)
        ;;
esac
$PACMAN "${pkg[@]}"

cp -rf etc /etc

echo -e "${BOLD}${GREEN}DONE. You can reboot.${NORMAL}"

# TODO install dwm
