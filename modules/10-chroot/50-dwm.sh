#!/bin/bash
#shellcheck disable=SC2154

git clone --depth 1 https://git.maby.dev/ange/.dotfiles.git /tmp/dotfiles
/tmp/dotfiles/.config/suckless/update.sh
