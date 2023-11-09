#!/bin/bash -ex
cd "$(dirname "$0")"
. ./config

arch-chroot /mnt/ su "$username" -c bash -ex \
    < src/dotfiles.sh
