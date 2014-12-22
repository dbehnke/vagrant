#!/bin/bash -eux
yum -y install docker-io
usermod -aG docker vagrant
systemctl enable docker
