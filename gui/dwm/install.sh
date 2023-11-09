#!/bin/bash -e
cd "$(dirname "$0")"
. ./config
. ../../lib.sh

awk 'p; /pattern/{p=1}' "$(basename "$0")" | arch-chroot /mnt/ bash -ex; exit


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
pac "${pkg[@]}"

cp -rfT rootfs /

git clone https://git.maby.dev/ange/suckless.git /tmp/suckless/
cd /tmp/suckless
./update.sh

echo -e "${BOLD}${GREEN}DONE. I recommend you to install dotfiles.sh to get a fully functioning config.${NORMAL}"
