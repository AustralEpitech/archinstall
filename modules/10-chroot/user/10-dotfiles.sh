#!/bin/bash
#shellcheck disable=SC2154

config=(git --git-dir "$HOME/.dotfiles" --work-tree "$HOME")
repo='https://git.maby.dev/ange/.dotfiles.git'

git clone --bare "$repo" "$HOME/.dotfiles"
"${config[@]}" checkout -f
"${config[@]}" submodule update --init --recursive --remote
"${config[@]}" config status.showUntrackedFiles no
"${config[@]}" remote set-url origin git@git.maby.dev:ange/.dotfiles.git
