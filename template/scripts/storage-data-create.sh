#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

echo \"create lvm data volumes ...\"
lvcreate -L ${STORAGE_SIZE} -n ${VM_PREFIX}kubernetes-storage-data ${LVM_VG}

echo \"format data volum ...\"
wipefs /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-storage-data
mkfs.ext4 -F /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-storage-data

function create_storage {
	name=\"\$1\"
	echo \"create lvm data volumes for \${name}\"
	lvcreate -L ${STORAGE_SIZE} -n ${DISK_PREFIX}kubernetes-\${name}-storage ${LVM_VG}

	echo \"format data volum ...\"
	wipefs /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-\${name}-storage
	mkfs.xfs -i size=512 /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-\${name}-storage
}

for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	create_storage \"worker\${i}\"
done

