#!/bin/bash

echo \"undefine machines ...\"
virsh undefine ${VM_PREFIX}kubernetes-master
virsh undefine ${VM_PREFIX}kubernetes-storage
for ((i=0; i < ${ETCD_AMOUNT}; i++)) do
	virsh undefine ${VM_PREFIX}kubernetes-etcd\${i}
done
for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	virsh undefine ${VM_PREFIX}kubernetes-worker\${i}
done
