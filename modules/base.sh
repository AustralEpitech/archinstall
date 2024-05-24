#!/bin/bash
#shellcheck disable=SC2154

for i in modules/00-prechroot/*.sh; do
    bash -x "$i"
done

for i in modules/10-chroot/*.sh; do
    arch-chroot /mnt/ bash -x "$i"
done

for i in modules/20-user/*.sh; do
    arch-chroot /mnt/ sudo -u "$username" bash -x "$i"
done
