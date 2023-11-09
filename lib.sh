#!/bin/bash

set -a

if [ -t 1 ]; then
    NORMAL='\e[0m'
    BOLD='\e[1m'
    GREEN='\e[32m'
fi

function pac() {
    yes | pacman --needed -Syu "$@"
}

set +a
