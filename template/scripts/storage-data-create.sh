#!/bin/bash

echo \"create lvm data volumes ...\"
lvcreate -L ${STORAGE_SIZE} -n ${VM_PREFIX}kubernetes-storage-data ${LVM_VG}

echo \"format data volum ...\"
wipefs /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-storage-data
mkfs.btrfs /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-storage-data
