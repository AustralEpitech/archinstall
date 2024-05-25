#!/bin/bash
#shellcheck disable=SC2154

[ -s flatpak.txt ] && xargs flatpak install -y < flatpak.txt
