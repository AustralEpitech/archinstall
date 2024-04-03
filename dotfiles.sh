#!/bin/bash -ex
cd "$(dirname "$0")"
. ./config
. ./src/lib.sh

cat src/dotfiles.sh | arch-chroot /mnt/ su - "$username" -c 'bash -ex'

echo "${BOLD}${GREEN}DONE.${NORMAL}"
