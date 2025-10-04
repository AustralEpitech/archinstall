#!/bin/bash

forge=git.gmoker.com
repo=ange/dotfiles.git

config=(git --git-dir "$HOME/.dotfiles" --work-tree "$HOME")

git clone --bare "https://$forge/$repo" "$HOME/.dotfiles"
"${config[@]}" checkout -f
"${config[@]}" submodule update --init --recursive --remote
"${config[@]}" config status.showUntrackedFiles no
"${config[@]}" remote set-url origin "git@$forge:$repo"
