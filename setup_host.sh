#!/bin/bash

apt update
apt install -y nfs-common
mkdir -p /var/nfs/keys

while [ ! -f /var/nfs/keys/id_rsa ]; do
  mount 192.168.1.1:/var/nfs/keys /var/nfs/keys
  sleep 10
done

cp /var/nfs/keys/id_rsa* /users/zw920902/.ssh/
chown zw920902: /users/zw920902/.ssh/id_rsa*
runuser -u zw920902 -- cat /users/lngo/.ssh/id_rsa.pub >> /users/zw920902/.ssh/authorized_keys
