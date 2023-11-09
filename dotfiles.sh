#!/bin/bash -ex
cd "$(dirname "$0")"
. ./config

cat src/dotfiles.sh | arch-chroot /mnt/ su "$username" -c 'bash -ex'
