#!/bin/bash -e
cd "$(dirname "$0")"


cp -rfT rootfs/ /mnt/
cat config ../../src/lib.sh src/install.sh | arch-chroot /mnt/ bash -ex
