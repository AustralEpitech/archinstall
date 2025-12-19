#!/bin/sh

BOLD='\e[1m'
GREEN='\e[32m'
NORMAL='\e[0m'

cp logs.out /mnt/var/log/archinstall.log

printf '%s' "${BOLD}${GREEN}DONE. Umount? [Y/n]${NORMAL} "
read -r ANS
if echo "$ANS" | grep -qiP '^(y|$)'; then
    exit
fi

umount -R /mnt/
