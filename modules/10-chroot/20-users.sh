#!/bin/sh
#shellcheck disable=SC2154

shell=$(sed -n "/$shell/{p;q}" /etc/shells)
useradd -mG wheel,video "$username" -s "${shell:-/bin/bash}"

if [ -n "$rootpasswd" ]; then
    printf '%s\n' "root:$rootpasswd" | chpasswd
fi
printf '%s\n' "$username:$userpasswd" | chpasswd

if [ "$autologin" = 1 ]; then
    systemctl edit --drop-in=autologin.conf --stdin getty@tty1.service <<EOF
[Service]
Type=simple
ExecStart=
ExecStart=-/sbin/agetty -a $username - \${TERM}
EOF
fi
