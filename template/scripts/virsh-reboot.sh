#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

echo \"reboot machines ...\"
virsh reboot ${VM_PREFIX}kubernetes-master
virsh reboot ${VM_PREFIX}kubernetes-storage
for ((i=0; i < ${ETCD_AMOUNT}; i++)) do
	virsh reboot ${VM_PREFIX}kubernetes-etcd\${i}
done
for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	virsh reboot ${VM_PREFIX}kubernetes-worker\${i}
done

echo \"done\"
