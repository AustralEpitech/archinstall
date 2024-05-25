#!/bin/bash

set -a
. ./config
set +a

# cp chroot?
bash ./modules/"$install_type".sh
