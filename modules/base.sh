#!/bin/bash
#shellcheck disable=SC2154

for i in modules/00-prechroot/*.sh; do
    bash -x "$i"
done

cp -r modules/chroot/ /mnt/

for i in modules/10-chroot/*.sh; do
    arch-chroot /mnt bash -x "${i/modules/}"
done

for i in modules/10-chroot/user/*.sh; do
    arch-chroot /mnt su - "$username" -c "bash -x '${i/modules/}'"
done

for i in modules/20-postchroot/*.sh; do
    bash -x "$i"
done

rm -rf /mnt/chroot/
