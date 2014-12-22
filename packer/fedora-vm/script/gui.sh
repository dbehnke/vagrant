#!/bin/bash -eux
yum -y groupinstall mate-desktop-environment
systemctl enable lightdm
rm -f /etc/systemd/system/default.target
ln -s /lib/systemd/system/graphical.target /etc/systemd/system/default.target
