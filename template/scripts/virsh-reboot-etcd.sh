#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

for ((i=0; i < ${ETCD_AMOUNT}; i++)) do
	virsh reboot ${VM_PREFIX}kubernetes-etcd\${i}
done
