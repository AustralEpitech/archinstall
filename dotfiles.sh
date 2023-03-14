#!/bin/bash -e
cd

NORMAL='\e[0m'
BOLD='\e[1m'
GREEN='\e[32m'

config="git --git-dir $HOME/.dotfiles --work-tree $HOME"
repo='https://git.maby.dev/ange/.dotfiles.git'

if [ "$EUID" = 0 ]; then
    echo 'You are currently logged in as root. Continue?'
    read -r
fi

git clone --bare "$repo" "$HOME/.dotfiles"

while ! $config checkout; do
    echo 'Please the error above and press enter:'
    read -r
done

$config submodule update --init --recursive --remote
$config config status.showUntrackedFiles no

chsh -s /bin/zsh

echo -e "${BOLD}${GREEN}DONE. You need to reboot to apply the changes.${NORMAL}"
