#!/bin/bash

echo 'If you want Secure Boot support, you need to put your system in Setup Mode'
read -r

exec &> >(tee logs.out)

set -a
. ./config
set +a

printf '%s\n' "${pkg[@]}" > pkglist.txt

bash ./modules/"$install_type".sh
