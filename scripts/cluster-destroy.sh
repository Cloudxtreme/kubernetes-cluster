#!/bin/sh

./virsh-destroy.sh

echo "remove lvm volumes ..."
lvremove /dev/system/node-master
lvremove /dev/system/node-worker0
lvremove /dev/system/node-worker1
lvremove /dev/system/node-worker2

echo "done"
