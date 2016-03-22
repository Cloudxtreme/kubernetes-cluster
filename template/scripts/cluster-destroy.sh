#!/bin/sh

./virsh-destroy.sh

#./storage-data-destroy.sh

echo \"remove lvm volumes ...\"
lvremove /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-master
lvremove /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-storage
lvremove /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-worker0
lvremove /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-worker1
lvremove /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-worker2

echo \"done\"