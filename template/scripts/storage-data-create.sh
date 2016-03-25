#!/bin/bash

echo \"create lvm data volumes ...\"
lvcreate -L 10G -n ${VM_PREFIX}kubernetes-storage-data ${LVM_VG}

echo \"format data volum ...\"
wipefs /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-storage-data
mkfs.ext4 -F /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-storage-data
