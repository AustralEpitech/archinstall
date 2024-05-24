#!/bin/bash
#shellcheck disable=SC2154

systemctl enable \
    iwd.service \
    nftables.service \
    reflector.timer \
    systemd-networkd.service \
    systemd-resolved.service \
    systemd-timesyncd.service \
    tlp.service
