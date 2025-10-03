#!/bin/bash
#shellcheck disable=SC2154

for f in modules/00-prechroot/*.sh; do
    bash -x "$f"
done

for f in modules/10-chroot/*.sh; do
    arch-chroot /mnt bash -x < "$f"
done

for f in modules/10-chroot/user/*.sh; do
    arch-chroot /mnt su - "$username" -c "bash -x" < "$f"
done

for i in modules/20-postchroot/*.sh; do
    bash -x "$i"
done
