#!/bin/bash
#shellcheck disable=SC2154

BOLD=$'\e[1m'
GREEN=$'\e[32m'
NORMAL=$'\e[0m'

echo "${BOLD}${GREEN}DONE. Umount? [Y/n]${NORMAL} " && read -r ANS

case "$ANS" in
    ''|[Yy]*) ;;
    *) exit ;;
esac

awk '/mnt/ {print $1}' < /proc/swaps | xargs swapoff
umount -R /mnt/
