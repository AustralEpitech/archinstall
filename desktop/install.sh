#!/bin/bash
cd -- "$(dirname "$0")"
. ../src/lib.sh

cat config ../src/lib.sh src/install.sh | arch-chroot /mnt/ bash

echo "${BOLD}${GREEN}DONE${NORMAL}"
