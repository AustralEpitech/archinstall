#!/bin/bash
#shellcheck disable=SC2154

shell="$(sed -n "/$shell/{p;q}" /etc/shells)"
useradd -mG wheel,video "$username" -s "${shell:-/bin/bash}"

if [ -n "$rootpasswd" ]; then
    echo "root:$rootpasswd" | chpasswd
fi
echo "$username:$userpasswd" | chpasswd
