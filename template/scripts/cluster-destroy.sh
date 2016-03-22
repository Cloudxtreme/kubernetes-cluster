#!/bin/sh

./virsh-destroy.sh

#./storage-data-destroy.sh

echo \"remove lvm volumes ...\"
lvremove /dev/vg0/bb_kubernetes-master
lvremove /dev/vg0/bb_kubernetes-storage
lvremove /dev/vg0/bb_kubernetes-worker0
lvremove /dev/vg0/bb_kubernetes-worker1
lvremove /dev/vg0/bb_kubernetes-worker2

echo \"done\"
