#!/bin/bash
#shellcheck disable=SC2154

[ -n "$flatpak" ] && flatpak install -y "${flatpak[@]}"
