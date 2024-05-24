#!/bin/bash
#shellcheck disable=SC2154

shell="$(sed -n "/$shell/{p;q}" /etc/shells)"
useradd -mG wheel,video "$username" -s "${shell:-/bin/bash}"

echo "root:$root_passwd" | chpasswd
echo - "$username:$user_passwd" | chpasswd
