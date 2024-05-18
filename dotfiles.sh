#!/bin/bash
cd -- "$(dirname "$0")"
. ./config
. ./src/lib.sh

cat src/dotfiles.sh | arch-chroot /mnt/ su - "$username" -c 'bash'

echo "${BOLD}${GREEN}DONE.${NORMAL}"
