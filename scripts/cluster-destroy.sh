#!/bin/sh

./virsh-destroy.sh

echo "remove lvm volumes ..."
lvremove /dev/vg0/kubernetes-master
lvremove /dev/vg0/kubernetes-worker0
lvremove /dev/vg0/kubernetes-worker1
lvremove /dev/vg0/kubernetes-worker2

echo "done"
