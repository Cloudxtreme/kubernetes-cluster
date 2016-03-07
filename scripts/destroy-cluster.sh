#!/bin/sh

echo "destroying machines ..."
virsh destroy node-master
virsh destroy node-worker0
virsh destroy node-worker2
virsh destroy node-worker3

echo "undefine machines ..."
virsh undefine node-master
virsh undefine node-worker0
virsh undefine node-worker2
virsh undefine node-worker3

echo "remove lvm volumes ..."
lvremove /dev/system/node-master
lvremove /dev/system/node-worker0
lvremove /dev/system/node-worker2
lvremove /dev/system/node-worker2

echo "done"
