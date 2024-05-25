#!/bin/bash

exec &> >(tee logs.out)

set -a
. ./config
set +a

printf '%s\n' "${pkg[@]}" > pkglist.txt

bash ./modules/"$install_type".sh
