#!/bin/sh

systemctl enable iwd.service
systemctl enable nftables.service
systemctl enable reflector.timer
systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service
systemctl enable systemd-timesyncd.service
systemctl enable tlp.service
