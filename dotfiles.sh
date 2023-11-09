#!/bin/bash -ex
cd "$(dirname "$0")"
. ./config
. ./lib.sh

awk 'p; /pattern/{p=1}' "$0" | arch-chroot /mnt/ su "$username" -c bash -ex; exit


config=(git --git-dir "$HOME/.dotfiles" --work-tree "$HOME")
repo='https://git.maby.dev/ange/.dotfiles.git'

if [ "$EUID" = 0 ]; then
    echo 'You are currently logged in as root. Continue?'
    read -r
fi

git clone --bare "$repo" "$HOME/.dotfiles"

"${config[@]}" checkout -f
"${config[@]}" submodule update --init --recursive --remote
"${config[@]}" config status.showUntrackedFiles no

echo -e "${BOLD}${GREEN}DONE. You need to reboot to apply the changes.${NORMAL}"
