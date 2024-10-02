#!/bin/bash
#shellcheck disable=SC2154

shell="$(sed -n "/$shell/{p;q}" /etc/shells)"
useradd -mG wheel,video "$username" -s "${shell:-/bin/bash}"

[ -n "$rootpasswd" ] && echo "root:$rootpasswd" | chpasswd
echo "$username:$userpasswd" | chpasswd
