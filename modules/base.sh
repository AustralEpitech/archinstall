#!/bin/bash
#shellcheck disable=SC2154

cp ./modules/chroot/ /mnt/
for i in *.sh; do
    bash -x "$i"
done

(cd ./modules/ || exit
    for i in ./chroot/*.sh; do
        arch-chroot /mnt/ bash -x "/$i"
    done

    for i in ./chroot/user/*.sh; do
        arch-chroot /mnt/ sudo -u "$username" bash -x "/$i"
    done
)

for i in ./modules/postchroot/*.sh; do
    bash -x "$i"
done

rm -rf /mnt/chroot/
