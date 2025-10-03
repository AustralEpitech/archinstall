#!/bin/bash

config=(git --git-dir "$HOME/.dotfiles" --work-tree "$HOME")
repo='https://git.gmoker.com/ange/dotfiles.git'

git clone --bare "$repo" "$HOME/.dotfiles"
"${config[@]}" checkout -f
"${config[@]}" submodule update --init --recursive --remote
"${config[@]}" config status.showUntrackedFiles no
"${config[@]}" remote set-url origin git@git.gmoker.com:ange/dotfiles.git
