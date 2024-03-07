#!/bin/bash -ex
cd "$(dirname "$0")"
. ../src/lib.sh

cat config ../src/lib.sh src/install.sh | arch-chroot /mnt/ bash -ex

echo -e "${BOLD}${GREEN}DONE${NORMAL}"
