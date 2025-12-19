#!/bin/sh

repo=git.gmoker.com/ange/dotfiles.git

c() {
    git --git-dir "$HOME/.dotfiles" --work-tree "$HOME" "$@"
}

git clone --bare "https://$repo" "$HOME/.dotfiles"
c checkout -f
c submodule update --init --remote
c config status.showUntrackedFiles no
c remote set-url origin "ssh://git@$repo"
