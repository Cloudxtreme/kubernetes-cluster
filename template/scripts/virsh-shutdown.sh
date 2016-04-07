#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

echo \"shutdown machines ...\"
virsh shutdown ${VM_PREFIX}kubernetes-master
virsh shutdown ${VM_PREFIX}kubernetes-storage
for ((i=0; i < ${ETCD_AMOUNT}; i++)) do
	virsh shutdown ${VM_PREFIX}kubernetes-etcd\${i}
done
for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	virsh shutdown ${VM_PREFIX}kubernetes-worker\${i}
done

echo \"done\"
