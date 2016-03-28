#!/bin/bash

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

\${SCRIPT_ROOT}/virsh-destroy.sh
\${SCRIPT_ROOT}/virsh-undefine.sh

echo \"remove lvm volumes ...\"
lvremove /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-master
lvremove /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-storage
for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	lvremove /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-worker\${i}
done

echo \"done\"
