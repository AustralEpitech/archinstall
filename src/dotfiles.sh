#!/bin/bash
cd

config=(git --git-dir "$HOME/.dotfiles" --work-tree "$HOME")
repo='https://git.maby.dev/ange/.dotfiles.git'

set -x

git clone --bare "$repo" "$HOME/.dotfiles"

"${config[@]}" checkout -f
"${config[@]}" submodule update --init --recursive --remote
"${config[@]}" config status.showUntrackedFiles no
