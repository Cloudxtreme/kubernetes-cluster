#!/bin/sh

./virsh-destroy.sh

echo "remove lvm volumes ..."
lvremove /dev/system/kubernetes-master
lvremove /dev/system/kubernetes-worker0
lvremove /dev/system/kubernetes-worker1
lvremove /dev/system/kubernetes-worker2

echo "done"
