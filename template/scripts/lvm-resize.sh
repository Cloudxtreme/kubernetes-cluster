#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	lvextend --size ${SYSTEM_SIZE} /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-worker\${i}
done

