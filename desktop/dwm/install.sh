#!/bin/bash
cd -- "$(dirname "$0")"
. ../../src/lib.sh

cp -rfTv rootfs/ /mnt/
cat config ../../src/lib.sh src/install.sh | arch-chroot /mnt/ bash

echo "${BOLD}${GREEN}DONE${NORMAL}"
