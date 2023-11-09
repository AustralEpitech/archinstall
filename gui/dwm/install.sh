#!/bin/bash -e
cd "$(dirname "$0")"

arch-chroot /mnt/ bash -ex \
    < ../../src/lib.sh     \
    < config               \
    < src/install.sh
