#!/bin/bash -e
cd

if [ -t 1 ]; then
    NORMAL='\e[0m'
    BOLD='\e[1m'
    GREEN='\e[32m'
fi

config="git --git-dir $HOME/.dotfiles --work-tree $HOME"
repo='https://git.maby.dev/ange/.dotfiles.git'

if [ "$EUID" = 0 ]; then
    echo 'You are currently logged in as root. Continue?'
    read -r
fi

git clone --bare "$repo" "$HOME/.dotfiles"

$config checkout -f
$config submodule update --init --recursive --remote
$config config status.showUntrackedFiles no

echo -e "${BOLD}${GREEN}DONE. You need to reboot to apply the changes.${NORMAL}"
