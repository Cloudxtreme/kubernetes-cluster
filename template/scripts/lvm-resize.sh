#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	lvextend --size ${WORKER_SIZE} /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-worker\${i}
done

