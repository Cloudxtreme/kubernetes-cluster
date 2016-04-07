#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

echo \"destroying machines ...\"
virsh destroy ${VM_PREFIX}kubernetes-master
virsh destroy ${VM_PREFIX}kubernetes-storage
for ((i=0; i < ${ETCD_AMOUNT}; i++)) do
	virsh destroy ${VM_PREFIX}kubernetes-etcd\${i}
done
for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	virsh destroy ${VM_PREFIX}kubernetes-worker\${i}
done
