#!/bin/bash
#shellcheck disable=SC2154

for i in modules/prechroot/*.sh; do
    bash -x "$i"
done

cp -r modules/chroot/ /mnt/

for i in modules/chroot/*.sh; do
    arch-chroot /mnt bash -x "${i/modules/}"
done

for i in modules/chroot/user/*.sh; do
    arch-chroot /mnt su - "$username" -c "bash -x '${i/modules/}'"
done

for i in modules/postchroot/*.sh; do
    bash -x "$i"
done

rm -rf /mnt/chroot/
