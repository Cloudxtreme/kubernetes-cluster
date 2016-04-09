#!/bin/bash

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

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
