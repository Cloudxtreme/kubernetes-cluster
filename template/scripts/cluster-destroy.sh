#!/bin/bash

set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

\${SCRIPT_ROOT}/virsh-destroy.sh
\${SCRIPT_ROOT}/virsh-undefine.sh

echo \"remove lvm volumes ...\"

lvremove /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-master
lvremove /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-master-docker

lvremove /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-storage
lvremove /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-storage-docker

for ((i=0; i < ${ETCD_AMOUNT}; i++)) do
	lvremove /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-etcd\${i}
	lvremove /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-etcd\${i}-docker
done

for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	lvremove /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-worker\${i}
	lvremove /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-worker\${i}-docker
done

echo \"done\"
