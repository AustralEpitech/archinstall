#!/bin/bash -ex
cd "$(dirname "$0")"

arch-chroot /mnt/ bash -ex \
    < config               \
    < ../src/lib.sh        \
    < src/install.sh
