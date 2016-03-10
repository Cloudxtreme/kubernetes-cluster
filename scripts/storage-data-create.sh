#!/bin/sh

echo "create lvm data volumes ..."
lvcreate -L 10G -n bb_kubernetes-storage-data vg0

echo "format data volum ..."
wipefs /dev/vg0/bb_kubernetes-storage-data
mkfs.ext4 -F /dev/vg0/bb_kubernetes-storage-data
