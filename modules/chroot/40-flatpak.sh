#!/bin/bash
#shellcheck disable=SC2154

[ -s /chroot/flatpak.txt ] && xargs flatpak install -y < /chroot/flatpak.txt
