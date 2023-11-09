#!/bin/bash -e
cd "$(dirname "$0")"
. ./config
. ../../lib.sh

if [ "$EUID" != 0 ]; then
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
pac "${pkg[@]}"

cp -rfT rootfs /

git clone https://git.maby.dev/ange/suckless.git /tmp/suckless/
cd /tmp/suckless
./update.sh

echo -e "${BOLD}${GREEN}DONE. I recommend you run \`su ${username-\$username} \
-c ./dotfiles\` to get a fully functioning config.${NORMAL}"
