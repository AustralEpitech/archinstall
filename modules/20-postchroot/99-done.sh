#!/bin/bash

BOLD=$'\e[1m'
GREEN=$'\e[32m'
NORMAL=$'\e[0m'

read -rp "${BOLD}${GREEN}DONE. Umount? [Y/n]${NORMAL} " ANS
if ! [[ "${ANS,}" =~ ^$|^y ]]; then
    exit
fi

umount -R /mnt/
