#!/bin/bash

exec &> >(tee logs.out)

set -a
. ./config
set +a

bash ./modules/"$install_type".sh
