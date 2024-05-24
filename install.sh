#!/bin/bash

set -a
. ./config
set +a

./modules/"$install_type".sh
