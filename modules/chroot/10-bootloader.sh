#!/bin/bash
#shellcheck disable=SC2154

bootctl install

root="$(findmnt -nr -o source /)"

cryptdev="$(cryptsetup status "$root" | awk '/device/ {print $2}')"
[ -n "$cryptdev" ] && {
    uuid="$(blkid | grep "$cryptdev" | awk '{print $2}')"
    options="cryptdevice=$uuid:$(basename "$root") "
}

options="${options}root=$root"

for f in /boot/loader/entries/*.conf; do
    cat << EOF >> "$f"
options $options rw
EOF
done
