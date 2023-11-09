#!/bin/bash -e
cd "$(dirname "$0")"

cat config ../../src/lib.sh src/install.sh | arch-chroot /mnt/ bash -ex
