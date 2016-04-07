#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

lvremove /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-storage-data

function delete_storage {
	name=\"\$1\"
	echo \"remove lvm data volumes for worker \${name}\"
	lvremove /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-\${name}-storage
}

for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	delete_storage \"worker\${i}\"
done
