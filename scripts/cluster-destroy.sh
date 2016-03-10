#!/bin/sh

./virsh-destroy.sh

echo "remove lvm volumes ..."
lvremove /dev/vg0/bb_kubernetes-master
lvremove /dev/vg0/bb_kubernetes-storage
lvremove /dev/vg0/bb_kubernetes-worker0
lvremove /dev/vg0/bb_kubernetes-worker1
lvremove /dev/vg0/bb_kubernetes-worker2

#lvremove /dev/vg0/bb_kubernetes-storage-volume

echo "done"
