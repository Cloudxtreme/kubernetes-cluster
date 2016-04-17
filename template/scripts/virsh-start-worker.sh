#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	virsh start ${VM_PREFIX}kubernetes-worker\${i}
done
