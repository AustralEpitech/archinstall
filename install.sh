#!/bin/bash

set -a
. ./config
set +a

bash ./modules/"$install_type".sh
